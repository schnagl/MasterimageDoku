#requires -version 5
# Aktuell keine weiteren benötigte Module 

<#
.SYNOPSIS
Documentation of the Changes since the Last Sealing and Upload to ITGLue per WebHook.
.DESCRIPTION
To upload the Changes of your Masterimage to ITGlue while sealing the Script add the Script to the Preparation-Folder.
Please add the OrgID of the Organissation to the Script.

.NOTES
Masterimage Script
Company: EDV-BV
Author: Christian Schnagl 
Creation Date: 2021-11-18
####

Changelog:
2021-11-25    First Run & Anpassungen Upload
2021-11-23    Neues GUI
2021-11-20    First Run
2021-11-19    Speichern der Informationen
2021-11-18    Automatische Automatisierung - Anpassung für Github
2021-11-16    Grundsätzliche Anpassungen Script - Hinzufügen des Webhooks


#>

#################################################################################################################

    ########################### Option 1 - Powershell ###########################
    param(
        #$CSV                    = $NULL,    # Global im Script
        #$ITGlueOrgID            = $NULL    # Per CSV / Direct
    )


    ########################### Basic Infos ###########################
    #$ITGlueOrgID = 2037545059041452
    $FlexAssetName = "Masterimage" # Name des Assets das Angelegt werden soll
    $ScriptVersion = "0.82"

    $Script:InstallPath = "C:\ProgramData\ITGlueMasterimage"
    $LastPassInfoPath = $Script:InstallPath + "\PassInfo.csv"
    #BISFPath = ""

#---------------------------------------------------------[Initialisations]--------------------------------------------------------
#region Initialisation
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Variaben
$Costumers                = $NULL
$Script:ITGlueOrgID       = $NULL

# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
#endregion Initialisation
#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#-----------------------------------------------------------[Functions]------------------------------------------------------------
#region Function Definition
  function Invoke-Webhook{
    param(
      $FlexAssetBody,
      $ITGlueOrgID,
      $FlexAssetName,
      $FieldName #Feldname der überprüft werden soll - z.B. Hostname
    )
  
    Write-Host "Sending to Webhook"
    #$WebhookURL = 'https://1c526335-77da-4dac-ba6c-295357be5a2e.webhook.dewc.azure-automation.net/webhooks?token=LQXUOUW2deeCwALqx9v9bUzxoNjVoraMd9aLkQte4IY%3d'
    $UploadJSON = ConvertTo-Json -InputObject $FlexAssetBody
    $header = @{ 
      ITGlueOrgID   = $ITGlueOrgID 
      FlexAssetName = $FlexAssetName
      FieldName    = $FieldName      
    }
    write-host $Host
    $response = Invoke-RestMethod -Method post -Uri $Script:WebhookURL -Body $UploadJSON -Headers $header
  
  }
  function Get-Changes-Software{
    $UpdatedSoftware = @()
    $Softwares = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate 
    $Softwarecount = 0
    #Set-Line -Text "Installierte Software"
  
    foreach($Software in $Softwares){
      if($Null -ne $Software.InstallDate){
        $Softwaredate = $Software.InstallDate.Insert(4,"/")
        $Softwaredate = $Softwaredate.Insert(7,"/")
  
        if((get-date $Softwaredate).date -ge (get-date $LastPassDate).date){
          $Softwarecount = $Softwarecount + 1
          #Set-Line -Text $Software.InstallDate, "-", $Software.Publisher, "|",$Software.DisplayName, $Software.DisplayVersion
          $Updatedsoftware += $Software
  
        }
      }
    }
    if($Softwarecount -eq 0){
      #Set-Line -Text "No Changes"
    }
    return $UpdatedSoftware
  }
  function Get-Changes-Patches {
    $Updates = Get-WmiObject win32_quickfixengineering | Select-Object InstalledOn, HotfixID, Description, InstalledBy
    $InstalledPatches = @()
    #Set-Line -Text "Installed Patches"
  
    foreach($Update in $Updates){
      if($Null -ne $Update.InstalledOn){
        if((get-date $Update.InstalledOn).date -ge (get-date $LastPassDate).date){
          $Updatecount = $Updatecount +=1
          #Set-Line -Text (Get-date $Update.InstalledOn -Format "dd.MM.yyyy"),$Update.HotFixID,$Update.Description
          $InstalledPatches += $Update
        }
      }
  
    }
    if($Updatecount -eq 0){
      #Set-Line -Text "No Changes"
    }
  
    return $InstalledPatches
  }
  function Get-CustomFlexAssetBody{
    $DateToday = Get-Date -format "yyyy-MM-dd"
    $Hostname   = hostname
    $Firma = $ComboBoxFirma.Text
    $User = $TextBoxEditor.text
    $Discussed = $TextBoxConsultant.text
    $Ticket = $TextBoxTicket.text
    $Comment = $TextBoxComment.text
    $Softwares = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | ConvertTo-Html -Fragment | Out-String
    $Updates = Get-WmiObject win32_quickfixengineering | Select-Object InstalledOn, HotfixID, Description, InstalledBy | ConvertTo-Html -Fragment | Out-String
    $UploadSoftware = $Script:ChangesSoftware | ConvertTo-Html -Fragment | Out-String
    $UploadPatches = $Script:ChangesPatches | ConvertTo-Html -Fragment | Out-String
  
    if($Null -eq $User){
      [System.Windows.Forms.MessageBox]::Show("User Required","Missing User",[System.Windows.Forms.MessageBoxButtons]::OKCancel,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
    else{
      #Vorbereitung der Daten  
      $FlexAssetBody = @{
        type       = 'flexible-assets'
        attributes = @{
            #ITGlueOrgID   = $Script:ITGlueOrgID 
            traits = @{
                'hostname'        = $Hostname
                'update'          = $DateToday
                'change-company'  = $Firma
                'change-user'     = $User
                'discussed'       = $Discussed
                'ticket'          = $Ticket
                'comment'         = $Comment
                'softwarelist'    = $Softwares
                'updatelist'      = $Updates
                'changes-software'= $UploadSoftware
                'changes-windows-patches' = $UploadPatches
                }
            }
        }
        return $FlexAssetBody
        #$FlexAssetBody.attributes.traits
    }
  
  }
  function Get-LastPassInfo{
    If (Test-Path $LastPassInfoPath -PathType leaf) {
      $LastPass = Import-csv $LastPassInfoPath -Delimiter ";"
    }
    else{
      $Lastpass = $NULL
    }
  
    return $LastPass
  }
  function Set-PassInfo{
    $CurDate = Get-Date
    $CustomersString = $Customers -join ','
    $Info = New-Object PSCustomObject
    $Info | Add-Member -type NoteProperty -name "ScriptVersion" -Value $ScriptVersion
    $Info | Add-Member -type NoteProperty -name "PassDate" -Value $CurDate
    $Info | Add-Member -type NoteProperty -name "ITGlueOrgID" -Value $Script:ITGlueOrgID
    $Info | Add-Member -type NoteProperty -name "Customers" -Value  $CustomersString
    $Info | Export-CSV "C:\ProgramData\ITGlueMasterimage\PassInfo.csv" -Encoding ascii -Force -NoTypeInformation -Delimiter ";"
    return
  }
  function Get-NewVersion{
    param(
      [String]$PathExistingVersion = "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/ITGLUE_Masterimage.ps1"
    )
    If (Test-Path "$PSScriptRoot\MasterimageScriptUpdater.ps1" -PathType leaf) {
      Remove-Item -Path "$PSScriptRoot\MasterimageScriptUpdater.ps1" -Force
    }
    $WebResponseVersion = Invoke-WebRequest -UseBasicParsing $PathExistingVersion
    If (!$WebVersion) {
        $WebVersion = (($WebResponseVersion.tostring() -split "[`r`n]" | select-string "ScriptVersion =" | Select-Object -First 1) -split "=")[1].Trim()
        $WebVersion = $WebVersion.Replace('"','')
    }
    If ($WebVersion -gt $ScriptVersion) {
        $NewerVersion = $true
    }
    else{
        $NewerVersion = $false
    }
  
    If ($NewerVersion -eq $false) {
      # No new version available
      write-Host "Versioncheck - Version Up2Date" -ForegroundColor Green
      Write-Output ""
    }
    Else {
      # There is a new Script Version
      write-Host "Versioncheck - New Version Available" -ForegroundColor Red
      Write-Output ""
        
      $wshell = New-Object -ComObject Wscript.Shell
      $AnswerPending = $wshell.Popup("Do you want to download the new version?",0,"New Version Alert!",32+4)
      If ($AnswerPending -eq "6") {
        Invoke-ProgramParts
          $update = @'
              Remove-Item -Path "$PSScriptRoot\ITGLUE_Masterimage.ps1" -Force 
              Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/ITGLUE_Masterimage.ps1" -OutFile ("$PSScriptRoot\" + "ITGLUE_Masterimage.ps1")
              write-host "New Version downloaded"
              & "$PSScriptRoot\ITGLUE_Masterimage.ps1"
'@
          $update > $PSScriptRoot\MasterimageScriptUpdater.ps1
          write-host $PSScriptRoot
          & "$PSScriptRoot\MasterimageScriptUpdater.ps1"
          Break
      }
      
    }
  }
  function Invoke-ProgramParts{
    Remove-Item -Path "$Script:InstallPath\ITGLUE_Masterimage_GUI.ps1" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Script:InstallPath\ITGLUE_Masterimage_FirstRunGUI.ps1" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Script:InstallPath\EDVBV_ICON.ico" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Script:InstallPath\EDVBV_LOGO.png" -Force -ErrorAction SilentlyContinue

    Write-Host "Creating new Directory"
    new-item -ItemType Directory -Force -Path $Script:InstallPath     
    #FirstRunGUI
    Write-Host "Download FirstRunGUI"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/ITGLUE_Masterimage_FirstRunGUI.ps1" -OutFile ("$Script:InstallPath\" + "ITGLUE_Masterimage_FirstRunGUI.ps1")  
    #GUI
    Write-Host "Download GUI"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/ITGLUE_Masterimage_GUI.ps1" -OutFile ("$Script:InstallPath\" + "ITGLUE_Masterimage_GUI.ps1")
    #Images
    Write-Host "Download Icon"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/EDVBV_ICON.ico" -OutFile ("$Script:InstallPath\" + "EDVBV_ICON.ico")
    Write-Host "Download Image"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/EDVBV_LOGO.png" -OutFile ("$Script:InstallPath\" + "EDVBV_LOGO.png")
  }
  function set-Shortcut{
    param ( 
    [string]$TargetPath, 
    [string]$DestinationPath,
    [string]$Arguments,
    [string]$IconLocation 
    )

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($DestinationPath)
    $Shortcut.TargetPath = $SourceExe
    $Shortcut.Arguments = $Arguments
    $Shortcut.IconLocation = $IconLocation
    $Shortcut.Save() 
  }

  function Set-BISFLink {
    if(Test-Path "$Script:InstallPath\ITGLUE_Masterimage.ps1"){

    }
    else{
      Write-Host "Adding Masterimage Script to " +$Script:InstallPath
      Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/ITGLUE_Masterimage.ps1" -OutFile ("$Script:InstallPath\" + "ITGLUE_Masterimage.ps1")  
    }
    if(Test-Path "C:\Program Files (x86)\Base Image Script Framework (BIS-F)"){
      write-Host "BISF exists - Creating Link"
      set-Shortcut -TargetPath "powershell.exe" -DestinationPath "C:\Program Files (x86)\Base Image Script Framework (BIS-F)\Framework\SubCall\Preparation\Custom\Masterimage_Doku.lnk" -Arguments "& $Script:InstallPath\ITGLUE_Masterimage.ps1" -IconLocation "$Script:InstallPath\EDVBV_ICON.ico"
    }
    else{
      write-Host "BISF does not exists"

    }

  }
#endregion
#--------------------------------------------------------[Functions]--------------------------------------------------------

#---------------------------------------------------------[Actions]---------------------------------------------------------
#region Action Definitions
$ButtonSave_Click = {
  $Script:ITGlueOrgID = $TextBoxOrgID.text
  $Script:WebhookURL = $TextBoxWebhook.text
  $Customers = $RichTextBoxCustomerInput.Lines
  write-host "ORGID:" + $Script:ITGlueOrgID

  $FormFirstRun.Close()
  $FormA1.ShowDialog()
} 

$ButtonUpload_Click = {
  $FlexassetBody = Get-CustomFlexAssetBody
  Invoke-Webhook -FlexAssetBody $FlexAssetBody -FlexAssetName $FlexAssetName -ITGlueOrgID $Script:ITGlueOrgID -FieldName "hostname"
  
  $FormA1.Close()
  Set-PassInfo
  Set-BISFLink
}
$ButtonCancel_Click ={
}


$TableLayoutPanel1_Paint = {
}
$FlowLayoutPanel1_Paint = {
}
$Label1_Click = {
}
$Form1_Load = {
  $Script:ChangesSoftware = Get-Changes-Software
  $Script:ChangesPatches = Get-Changes-Patches

    ##Costumers hinzufügen
    Foreach($Item in $Customers){
      $Costumers += $Item
      $ComboBoxFirma.items.add($Item)
    }
    #$ComboBoxFirma.SelectedItem = $Costumers[0]


    $ListSoftware = New-Object System.collections.ArrayList
    if (($Script:ChangesSoftware | Measure-Object).Count -eq 1){
    $ListSoftware.Add($Script:ChangesSoftware)
    }
    elseif (($Script:ChangesSoftware | Measure-Object).Count -eq 0){
        Write-Host "No Software Changed"
        $DataGridViewSoftware.Visible = $false
    }
    else{
        $ListSoftware.AddRange($Script:ChangesSoftware)
    }

    $ListPatches = New-Object System.collections.ArrayList
    if (($Script:ChangesPatches | Measure-Object).Count -eq 1){
      $ListPatches.Add($Script:ChangesPatches)
    }
    elseif (($Script:ChangesPatches | Measure-Object).Count -eq 0){
        Write-Host "No Patches Changed"
        $DataGridViewPatches.Visible = $false
    }
    else{
        $ListPatches.AddRange($Script:ChangesPatches)
    }

    $DataGridViewSoftware.DataSource = $ListSoftware
    $DataGridViewPatches.DataSource = $ListPatches

    $DataGridViewRegistry.Visible = $false
}
#endregion
#---------------------------------------------------------[Actions]---------------------------------------------------------


#---------------------------------------------------------[Script]---------------------------------------------------------
#region Script

## Check New Version
Get-NewVersion

## Check Infos bereits gesetzt wurden
$LastPass = Get-LastPassInfo
if($NULL -ne $LastPass){
  $Script:ITGlueOrgID = $LastPass.ITGlueOrgID
  $LastPassDate = $LastPass.PassDate
  $LastPassDate = Get-Date $LastPassDate
  $Customers = $LastPass.Customers -split(",")
  $Script:WebhookURL = $LastPass.WebhookURL
}
else{
  Invoke-ProgramParts
  $LastPassDate = Get-Date "01.01.1900"
}

Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $Script:InstallPath '\ITGLUE_Masterimage_GUI.ps1')
. (Join-Path $Script:InstallPath '\ITGLUE_Masterimage_FirstRunGUI.ps1')


$PictureBoxFirstRun.ImageLocation = $Script:InstallPath+"\EDVBV_LOGO.png" #ToDo Download
$FormFirstRun.CancelButton        = $ButtonCancel
$FormFirstRun.Icon                = New-Object system.drawing.icon ($Script:InstallPath+"\EDVBV_ICON.ico") #ToDo Download
$PictureBox1.ImageLocation        = $Script:InstallPath+"\EDVBV_LOGO.png" #ToDo Download
$FormA1.CancelButton              = $ButtonCancel
$FormA1.Icon                      = New-Object system.drawing.icon ($Script:InstallPath+"\EDVBV_ICON.ico") #ToDo Download

if($NULL -ne $LastPass){
  ## Aufruf GUI
  $FormA1.ShowDialog()
}
else{
    ## Aufruf FirstRun
    $FormFirstRun.ShowDialog()
}
#endregion 
#---------------------------------------------------------[Script]---------------------------------------------------------
