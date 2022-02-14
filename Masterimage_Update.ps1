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
Version: 0.20
Company: EDV-BV
Author: Christian Schnagl 
Creation Date: 2021-11-18
####

Changelog:
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
    $ScriptVersion = "0.15"

    
    $LastPassInfoPath = "C:\ProgramData\ITGlueMasterimage\PassInfo.csv"

#---------------------------------------------------------[Initialisations]--------------------------------------------------------
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
#-----------------------------------------------------------[Functions]------------------------------------------------------------
function Set-Textbox{
  param(
    $CLine,
    $Fontsize,
    $Height,
    [switch]$Bold
  )
  $Textbox                         = New-Object system.Windows.Forms.TextBox
  $Textbox.multiline               = $false
  $Textbox.width                   = 170
  $Textbox.height                  = $Height
  $Textbox.location                = New-Object System.Drawing.Point(140,$CLine)
  $Textbox.Font                    = "Microsoft Sans Serif,$Fontsize"
  $Form.controls.Add($Textbox)

  return $Textbox
}
function Set-Label{
  param(
    $CLine,
    $Height,
    $Fontsize,
    $Text,
    [switch]$Bold
  )
  $Label                        = New-Object system.Windows.Forms.Label
  $Label.text                   = $Text
  $Label.AutoSize               = $true
  $Label.width                  = 25
  $Label.height                 = $Height
  $Label.location               = New-Object System.Drawing.Point(20,$CLine)
  if($Bold){
    $Label.Font                   = "Microsoft Sans Serif,$Fontsize,style=Bold"
  }
  else{
    $Label.Font                   = "Microsoft Sans Serif,$Fontsize"
  }
  $Form.controls.Add($Label)
  $RLine = $CLine + $Height + 20
  return $RLine
}
function Set-Line{
  param(
    $Text
  )
  $LNewSoftware                        = New-Object system.Windows.Forms.Label
  $LNewSoftware.text                   = $Text
  $LNewSoftware.AutoSize               = $true
  $LNewSoftware.width                  = 25
  $LNewSoftware.height                 = 20
  $LNewSoftware.location               = New-Object System.Drawing.Point(20,$Script:Line)
  $LNewSoftware.Font                   = 'Microsoft Sans Serif,8'
  $Form.controls.Add($LNewSoftware)
  $Script:Line = $Script:Line + 20
  return
}
<#function Get-Changes { 
    #$StartupDate = Get-CimInstance -ClassName win32_operatingsystem | Select-Object lastbootuptime
    $Softwares = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate 
    $Updates = Get-WmiObject win32_quickfixengineering 
    $Updatedsoftware = @()
    $Softwarecount = 0
    $Updatecount = 0


    $Script:Line = 310

    #Set-Line -Text "Installierte Software"

    foreach($Software in $Softwares){
      if($Null -ne $Software.InstallDate){
        $Softwaredate = $Software.InstallDate.Insert(4,"/")
        $Softwaredate = $Softwaredate.Insert(7,"/")

        if((get-date $Softwaredate).date -ge (get-date $LastPassDate).date){
          $Softwarecount = $Softwarecount + 1
          Set-Line -Text $Software.InstallDate, "-", $Software.Publisher, "|",$Software.DisplayName, $Software.DisplayVersion
          $Updatedsoftware += $Software

        }
      }
    }
    if($Softwarecount -eq 0){
      Set-Line -Text "No Changes"
    }
    $Updates = Get-WmiObject win32_quickfixengineering 

    Set-Line -Text "Installed Patches"
  
    foreach($Update in $Updates){
      if((get-date $Update.InstalledOn).date -ge (get-date $LastPassDate).date){
        $Updatecount = $Updatecount +=1
        Set-Line -Text (Get-date $Update.InstalledOn -Format "dd.MM.yyyy"),$Update.HotFixID,$Update.Description
      }
    }
    if($Updatecount -eq 0){
      Set-Line -Text "No Changes"
    }



}#>
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
    Set-Line -Text "No Changes"
  }
  return $UpdatedSoftware
}
function Get-Changes-Patches {
  $Updates = Get-WmiObject win32_quickfixengineering | Select-Object InstalledOn, HotfixID, Description, InstalledBy
  $InstalledPatches = @()
  Set-Line -Text "Installed Patches"

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
    Set-Line -Text "No Changes"
  }

  return $InstalledPatches
}

function Invoke-Webhook{
  param(
    $FlexAssetBody,
    $ITGlueOrgID,
    $FlexAssetName
  )


  $WebhookURL = 'https://1c526335-77da-4dac-ba6c-295357be5a2e.webhook.dewc.azure-automation.net/webhooks?token=LQXUOUW2deeCwALqx9v9bUzxoNjVoraMd9aLkQte4IY%3d'
  $UploadJSON = ConvertTo-Json -InputObject $FlexAssetBody
  $header = @{ FlexAssetName = $FlexAssetName}
  $response = Invoke-RestMethod -Method post -Uri $WebhookURL -Body $UploadJSON -Headers $header

}

function Get-CustomFlexAssetBody{
  $DateToday = Get-Date -format "yyyy-MM-dd"
  $Firma = $ComboFirma.text
  $User = $TextUser.text
  $Discussed = $TextDiscussed.text
  $Ticket = $TextTicket.text
  $Comment = $TextComment.text
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
      Invoke-Webhook -FlexAssetBody $FlexAssetBody -FlexAssetName $FlexAssetName -ITGlueOrgID $ITGlueOrgID
      #Set-ITGLUE    $ExistingFlexAsset -ITGlueOrgID $ITGlueOrgID -FlexAssetBody $FlexAssetBody
      $Form.Close()
      Set-PassInfo
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
  $Info = New-Object PSCustomObject
  $Info | Add-Member -type NoteProperty -name "ScriptVersion" -Value $ScriptVersion
  $Info | Add-Member -type NoteProperty -name "PassDate" -Value $CurDate
  $Info | Add-Member -type NoteProperty -name "ITGlueOrgID" -Value $ITGlueOrgID
  $Info | Export-CSV "C:\ProgramData\ITGlueMasterimage\PassInfo.csv" -Encoding ascii -Force -NoTypeInformation -Delimiter ";"
  return
}

function Get-NewVersion{
  param(
    [String]$PathExistingVersion = "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/Masterimage_Update.ps1"
  )
  If (Test-Path "$PSScriptRoot\MasterimageScriptUpdater.ps1" -PathType leaf) {
    Remove-Item -Path "$PSScriptRoot\MasterimageScriptUpdater.ps1" -Force
  }
  $WebResponseVersion = Invoke-WebRequest -UseBasicParsing $PathExistingVersion
  If (!$WebVersion) {
      $WebVersion = (($WebResponseVersion.tostring() -split "[`r`n]" | select-string "Version:" | Select-Object -First 1) -split ":")[1].Trim()
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
        $update = @'
            Remove-Item -Path "$PSScriptRoot\Masterimage_Update.ps1" -Force 
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/Masterimage_Update.ps1" -OutFile ("$PSScriptRoot\" + "Masterimage_Update.ps1")
            write-host "New Version downloaded"
            & "$PSScriptRoot\Masterimage_Update.ps1"
'@
        $update > $PSScriptRoot\MasterimageScriptUpdater.ps1
        write-host $PSScriptRoot
        & "$PSScriptRoot\MasterimageScriptUpdater.ps1"
        Break
    }
    
  }
}



#--------------------------------------------------------[Script Load]--------------------------------------------------------
#region Script Load
#LoadITGlue
$Hostname = Hostname


#endregion
#---------------------------------------------------------[Form]--------------------------------------------------------
#region Forms

$Form                    = New-Object system.Windows.Forms.Form
$Form.ClientSize         = '500,800'
$Form.text               = "EDV-BV Changehistory"
$Form.BackColor          = "#ffffff"
$Form.TopMost            = $false
$Icon                    = New-Object system.drawing.icon ("C:\Users\christian.schnagl\Downloads\edvbv.ico")
$Form.Icon               = $Icon

$Script:ChangesSoftware  = Get-Changes-Software
$Script:ChangesPatches   = Get-Changes-Patches
#Get-Changes

$LabelLine = Set-Label -Text "Aktualisierung Masterimage" -CLine 20 -Height 10 -Fontsize 20 -Bold
$LabelLine = Set-Label -Text "Automatische Dokumentation der Updates und Changes am Masterimage" -CLine 60 -Height 50 -Fontsize 10

$LabelLine = 120
$LabelLine = Set-Label -Text "Firma" -CLine $LabelLine -Height 10 -Fontsize 10


$ComboFirma                          = New-Object system.Windows.Forms.ComboBox
$ComboFirma.text                     = ""
$ComboFirma.width                    = 170
$ComboFirma.height                   = 20
@('EDV-BV','LOXXESS') | ForEach-Object {[void] $ComboFirma.Items.Add($_)}
$ComboFirma.SelectedIndex            = 0
$ComboFirma.location                 = New-Object System.Drawing.Point(140,120)
$ComboFirma.Font                     = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($ComboFirma))

$TextUser = Set-Textbox -CLine $Labelline -Height 20 -Fontsize 10
$LabelLine = Set-Label -Text "Bearbeiter" -CLine $Labelline -Height 10 -Fontsize 10

$TextDiscussed = Set-Textbox -CLine $Labelline -Height 20 -Fontsize 10
$LabelLine = Set-Label -Text "Besprochen mit" -CLine $Labelline -Height 10 -Fontsize 10

$TextTicket = Set-Textbox -CLine $Labelline -Height 20 -Fontsize 10
$LabelLine = Set-Label -Text "Ticketnummer" -CLine $Labelline -Height 10 -Fontsize 10

$TextComment = Set-Textbox -CLine $Labelline -Height 20 -Fontsize 10
$LabelLine = Set-Label -Text "Kommentar" -CLine $Labelline -Height 10 -Fontsize 10

$LabelLine += 10
$LabelLine = Set-Label -Text "Changes" -CLine $Labelline -Height 10 -Fontsize 10


$acceptBtn                       = New-Object system.Windows.Forms.Button
$acceptBtn.BackColor             = "#ffffff"
$acceptBtn.text                  = "Upload"
$acceptBtn.width                 = 90
$acceptBtn.height                = 30
$acceptBtn.location              = New-Object System.Drawing.Point(280,720)
$acceptBtn.Font                  = 'Microsoft Sans Serif,10'
$acceptBtn.ForeColor             = "#000"
$Form.AcceptButton   = $acceptBtn
$Form.Controls.Add($acceptBtn)

$acceptBtn.add_Click({
  Get-CustomFlexAssetBody
})

$cancelBtn                       = New-Object system.Windows.Forms.Button
$cancelBtn.BackColor             = "#ffffff"
$cancelBtn.text                  = "Cancel"
$cancelBtn.width                 = 90
$cancelBtn.height                = 30
$cancelBtn.location              = New-Object System.Drawing.Point(380,720)
$cancelBtn.Font                  = 'Microsoft Sans Serif,10'
$cancelBtn.ForeColor             = "#000"
$cancelBtn.DialogResult          = [System.Windows.Forms.DialogResult]::Cancel
$Form.CancelButton   = $cancelBtn
$Form.Controls.Add($cancelBtn)

#$Form.controls.AddRange(@($Titel,$Description,$PrinterStatus,$PrinterFound,$PrinterName,$PrinterNameLabel,$PrinterType,$AddPrinterBtn,$cancelBtn,$PrinterTypeLabel,$PrinterDetails))
$WindowsBtn                       = New-Object system.Windows.Forms.Button
$WindowsBtn.BackColor             = "#ffffff"
$WindowsBtn.text                  = "Changes Software"
$WindowsBtn.width                 = 80
$WindowsBtn.height                = 40
$WindowsBtn.location              = New-Object System.Drawing.Point(20,300)
$WindowsBtn.Font                  = 'Microsoft Sans Serif,8'
$WindowsBtn.ForeColor             = "#000"
$Form.Controls.Add($WindowsBtn)

$WindowsBtn.add_Click({
  $GridViewSoftware.Visible = $true
  $GridViewPatches.Visible = $false
})

$PatchesBtn                       = New-Object system.Windows.Forms.Button
$PatchesBtn.BackColor             = "#ffffff"
$PatchesBtn.text                  = "Changes Patches"
$PatchesBtn.width                 = 80
$PatchesBtn.height                = 40
$PatchesBtn.location              = New-Object System.Drawing.Point(100,300)
$PatchesBtn.Font                  = 'Microsoft Sans Serif,8'
$PatchesBtn.ForeColor             = "#000"
$Form.Controls.Add($PatchesBtn)

$PatchesBtn.add_Click({
  $GridViewSoftware.Visible = $false
  $GridViewPatches.Visible = $true
})


# Grid View Software
$ListSoftware = New-Object System.collections.ArrayList
if (($Script:ChangesSoftware | Measure-Object).Count -eq 1){
  $ListSoftware.Add($Script:ChangesSoftware)
}
elseif (($Script:ChangesSoftware | Measure-Object).Count -eq 0){
  $ListSoftware.Add($Script:ChangesSoftware)
}
else{
  $ListSoftware.AddRange($Script:ChangesSoftware)
}

$GridViewSoftware = New-Object System.Windows.Forms.DataGridView -Property @{
    Size=New-Object System.Drawing.Size(460,350)
    ColumnHeadersVisible = $true
    DataSource = $ListSoftware
    location = New-Object System.Drawing.Point(20,340)
    GridColor = "Black"
    BackgroundColor = "White"
    Visible = $true
}
$form.Controls.Add($GridViewSoftware)

# Grid View Patches
$ListPatches = New-Object System.collections.ArrayList
if (($Script:ChangesSoftware | Measure-Object).Count -eq 1){
  $ListPatches.Add($Script:ChangesPatches)
}
elseif (($Script:ChangesPatches | Measure-Object).Count -eq 0){
  $ListPatches.Add($Script:ChangesPatches)
}
else{
  $ListPatches.AddRange($Script:ChangesPatches)
}

$GridViewPatches = New-Object System.Windows.Forms.DataGridView -Property @{
    Size=New-Object System.Drawing.Size(460,350)
    ColumnHeadersVisible = $true
    DataSource = $ListPatches
    location = New-Object System.Drawing.Point(20,340)
    GridColor = "Black"
    BackgroundColor = "White"
    Visible = $false
}
$form.Controls.Add($GridViewPatches)


#endregion Forms
#---------------------------------------------------------[Script Write]--------------------------------------------------------




Get-NewVersion
$LastPass = Get-LastPassInfo
if($NULL -ne $LastPass){
  $LastPassDate = $LastPass.PassDate
  $LastPassDate = Get-Date $LastPassDate
}
else{
  $LastPassDate = Get-Date "01.01.1900"
}
if($Null -ne $LastPass.ITGlueOrgID){
  $ITGlueOrgID = $Lastpass.ITGlueOrgID

}
else{
  $ITGlueOrgID = Read-Host -Prompt "ITGlue OrgID benötigt"
}

[void]$Form.ShowDialog()

new-item -ItemType Directory -Force -Path "C:\ProgramData\ITGlueMasterimage" 



# Test 
#$RegistrySoftware = Get-ChildItem HKLM:\SOFTWARE -Recurse -ErrorAction SilentlyContinue
#$RegistrySoftware += Get-ChildItem HKLM:\SYSTEM -Recurse -ErrorAction SilentlyContinue
#reg export
# Registry Compare?