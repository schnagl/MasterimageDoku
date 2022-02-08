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
Creation Date: 2021-11-16
####

Changelog:
2022-02-08    Upload Registry Changes Deaktiviert - Probleme Webhook
2022-01-20    Registry Changes upload per CSV, NoGUI, Script Prozess angepasst, Bug-Fixes
2022-01-10    Registry Checker hinzugefügt
2021-12-15    WEBHook-ULR entfernt
2021-12-14    AutoScroll GUI + FirstRunGui hinzugefügt
2021-12-06    WebhookURL Ausgelagert & BIS-F Script
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
        $ITGlueOrgID            = $NULL,
        $Script:WebhookURL      = $NULL,
        $Script:Bearbeiter      = $NULL,
        [switch]$DeactivateGUI,         #Only First Run -> Changes in LastPass 
        [switch]$DeactivateBISF,        #Only First Run -> Changes in LastPass 
        [switch]$DeactivateSoftware,    #Only First Run -> Changes in LastPass 
        [switch]$DeactivatePatches,     #Only First Run -> Changes in LastPass 
        [switch]$DeactivateRegistry     #Only First Run -> Changes in LastPass 
    )


    ########################### Basic Infos ###########################
    #$ITGlueOrgID = 2037545059041452
    $FlexAssetName = "Masterimage" # Name des Assets das Angelegt werden soll
    $ScriptVersion = "1.00"

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
        $UploadJSON = ConvertTo-Json -InputObject $FlexAssetBody -Depth 5
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
            $Softwaredate = [DateTime]::ParseExact($Software.InstallDate, "yyyyMMdd", $null).ToString("dd.MM.yyyy")
    
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

        $UpdatedSoftware = $Updatedsoftware | where-object{$NULL -ne $_.Displayname} | Select-Object @{name='InstalledOn';expression= {[DateTime]::ParseExact($_.InstallDate, "yyyyMMdd", $null).ToString("dd.MM.yyyy")}}, DisplayName, DisplayVersion, Publisher | sort-object -property InstalledOn, DisplayName
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
    
        $InstalledPatches = $InstalledPatches | Select-Object @{name='InstalledOn';expression= {Get-Date $_.InstalledOn -format "dd.MM.yyyy"}},HotfixID, Description, InstalledBy | sort-object -property InstalledOn, HotfixID
        return $InstalledPatches
    }
    function Get-CustomFlexAssetBody{
        if(!$DeactivateGUI){
            $Firma = $ComboBoxFirma.Text
            $User = $TextBoxEditor.text
            $Discussed = $TextBoxConsultant.text
            $Ticket = $TextBoxTicket.text
            $Comment = $TextBoxComment.text
        }
        else{
            $Firma = "Autoupload EDV-BV"
            $User = $env:UserName
            $Discussed = ""
            $Ticket = ""
            $Comment = "No GUI Upload"
        }
        $DateToday = Get-Date -format "yyyy-MM-dd"
        $Hostname   = hostname

        $Softwares = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where-object{$NULL -ne $_.Displayname} | Select-Object DisplayName, @{name='InstalledOn';expression= {[DateTime]::ParseExact($_.InstallDate, "yyyyMMdd", $null).ToString("dd.MM.yyyy")}}, DisplayVersion, Publisher | sort-object -property DisplayName,InstalledOn | ConvertTo-Html -Fragment | Out-String
        $Updates = Get-WmiObject win32_quickfixengineering | Select-Object HotfixID, @{name='InstalledOn';expression= {Get-Date $_.InstalledOn -format "dd.MM.yyyy"}}, Description, InstalledBy | sort-object -property InstalledOn, HotfixID | ConvertTo-Html -Fragment | Out-String
        $UploadSoftware = $Script:ChangesSoftware | ConvertTo-Html -Fragment | Out-String
        $UploadPatches = $Script:ChangesPatches | ConvertTo-Html -Fragment | Out-String
        #$UploadRegistry = $Script:ChangesRegistry
        #$UploadRegSoftware = $Script:RegSoftware
        #$UploadRegSystem = $Script:RegSystem
        #$UploadRegNTUserDat = $Script:Regntuserdat

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
                    <#'changes-registry'      = @{
                        "content"   = $UploadRegistry
                        "file_name" = "RegistryChanges.csv"
                    }#> #0802
                    <#'changes-registry'      = @{
                        "content"   = $UploadRegSoftware
                        "file_name" = (get-date -Format "dd.MM.yyyy") +"-Software"
                    }
                    'registry-system'      = @{
                        "content"   = $UploadRegSystem
                        "file_name" = (get-date -Format "dd.MM.yyyy") +"-System"
                    }
                    'registry-ntuserdat'      = @{
                        "content"   = $UploadRegNTUserDat
                        "file_name" = (get-date -Format "dd.MM.yyyy") +"-NTUser.dat"
                    }#>

                    }
                }
            }
        return $FlexAssetBody
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
        $CustomersString = $Script:Customers -join ','
        $Info = New-Object PSCustomObject
        $Info | Add-Member -type NoteProperty -name "ScriptVersion" -Value $ScriptVersion
        $Info | Add-Member -type NoteProperty -name "PassDate" -Value $CurDate
        $Info | Add-Member -type NoteProperty -name "ITGlueOrgID" -Value $Script:ITGlueOrgID
        $Info | Add-Member -type NoteProperty -name "Customers" -Value  $CustomersString
        $Info | Add-Member -type NoteProperty -name "WebhookURL" -Value  $Script:WebhookURL
        $Info | Add-Member -type NoteProperty -name "DeactivateBISF" -Value  $DeactivateBISF
        $Info | Add-Member -type NoteProperty -name "DeactivateGUI" -Value  $DeactivateGUI
        $Info | Add-Member -type NoteProperty -name "DeactivateSoftware" -Value  $DeactivateSoftware
        $Info | Add-Member -type NoteProperty -name "DeactivatePatches" -Value  $DeactivatePatches
        $Info | Add-Member -type NoteProperty -name "DeactivateRegistry" -Value  $DeactivateRegistry

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
        if($Reinstall){
            Remove-Item -Path "$Script:InstallPath\ITGLUE_Masterimage_GUI.ps1" -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "$Script:InstallPath\ITGLUE_Masterimage_FirstRunGUI.ps1" -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "$Script:InstallPath\EDVBV_ICON.ico" -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "$Script:InstallPath\EDVBV_LOGO.png" -Force -ErrorAction SilentlyContinue
        }

        if(!(test-path -Path $Script:InstallPath)){
            #Directory
            Write-Host "Creating new Directory"
            new-item -ItemType Directory -Force -Path $Script:InstallPath  
        }
        if(!(test-path -Path "$Script:InstallPath\ITGLUE_Masterimage_FirstRunGUI.ps1")){
            #FirstRunGUI
            Write-Host "Download FirstRunGUI"
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/ITGLUE_Masterimage_FirstRunGUI.ps1" -OutFile ("$Script:InstallPath\" + "ITGLUE_Masterimage_FirstRunGUI.ps1")  
        }        
        if(!(test-path -Path "$Script:InstallPath\ITGLUE_Masterimage_GUI.ps1")){
            #GUI
            Write-Host "Download GUI"
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/ITGLUE_Masterimage_GUI.ps1" -OutFile ("$Script:InstallPath\" + "ITGLUE_Masterimage_GUI.ps1")
        }        
        if(!(test-path -Path "$Script:InstallPath\EDVBV_ICON.ico")){
            #Images
            Write-Host "Download Icon"
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/EDVBV_ICON.ico" -OutFile ("$Script:InstallPath\" + "EDVBV_ICON.ico")
        }        
        if(!(test-path -Path "$Script:InstallPath\EDVBV_LOGO.png")){
            #Images
            Write-Host "Download Image"
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/EDVBV_LOGO.png" -OutFile ("$Script:InstallPath\" + "EDVBV_LOGO.png")
        }        
        <#if(!(test-path -Path "$Script:InstallPath\RegistryChanges\")){
            #RegistryChangesView 
            write-host "Creating Folder RegistryChanges"
            mkdir "$Script:InstallPath\RegistryChanges\"
        }        
        if(!(test-path -Path "$Script:InstallPath\RegistryChanges\registrychangesview\")){
            #RegistryChangesView
            write-host "Download RegistryChangesView"
            Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/registrychangesview-x64.zip" -OutFile ($Script:InstallPath + "\RegistryChanges\" + "registrychangesview-x64.zip")
        }
        if(!(test-path -Path "$Script:InstallPath\RegistryChanges\registrychangesview\RegistryChangesView.exe")){
            #RegistryChangesView
            Expand-Archive -Path ("$Script:InstallPath\" + "\RegistryChanges\registrychangesview-x64.zip") -DestinationPath ("$Script:InstallPath\RegistryChanges\" + "registrychangesview") -force
        }#> #0802

    }
    function Get-FirstRegSnap {
        write-host "Creating First Registry Snapshot"
        . (join-path $Script:InstallPath "\RegistryChanges\registrychangesview\RegistryChangesView.exe") /createSnapshot "$Script:InstallPath\RegistryChanges\Snapshots\SnapshotOld"
    }
    function Get-Changes-Registry {
        . (join-path $Script:InstallPath "\RegistryChanges\registrychangesview\RegistryChangesView.exe")  /createSnapshot "$Script:InstallPath\RegistryChanges\Snapshots\SnapshotNew"
        #Compare 2 saved Registry snapshots and export the result to regcomp1.csv: 
        . (join-path $Script:InstallPath "\RegistryChanges\registrychangesview\RegistryChangesView.exe") RegistryChangesView /DataSourceDirection 1 /DataSourceType1 2 /DataSourceType2 2 /RegSnapshotPath1 "$Script:InstallPath\RegistryChanges\Snapshots\SnapshotOld" /RegSnapshotPath2 "$Script:InstallPath\RegistryChanges\Snapshots\SnapshotNew" /scomma  "$Script:InstallPath\RegistryChanges\RegChanges.csv"
        write-host "Start 5s Sleep - Waiting for Registry "
        start-sleep -Seconds 5
        while(!(test-path "$Script:InstallPath\RegistryChanges\RegChanges.csv")){
            write-host "Start another 5s Sleep - Registry-CSV not existing"
            start-sleep -Seconds 5
        }

        $RegChanges64 = ([convert]::ToBase64String(([IO.File]::ReadAllBytes("$Script:InstallPath\RegistryChanges\RegChanges.csv"))))

        return $RegChanges64
    }
    function Get-Registry{
        $Script:RegSoftware = ([convert]::ToBase64String(([IO.File]::ReadAllBytes("$Script:InstallPath\RegistryChanges\Snapshots\SnapshotNew\Software"))))
        $Script:Regntuserdat = ([convert]::ToBase64String(([IO.File]::ReadAllBytes("$Script:InstallPath\RegistryChanges\Snapshots\SnapshotNew\ntuser.dat"))))
        $Script:System = ([convert]::ToBase64String(([IO.File]::ReadAllBytes("$Script:InstallPath\RegistryChanges\Snapshots\SnapshotNew\system"))))
    }

    function Remove-OldRegistryKey{
        #Snapshots entfernen
        Write-Host "Deleting old Snapshot"
        $NewPath = (Join-Path $Script:InstallPath "\RegistryChanges\Snapshots\SnapshotNew")
        $OldPath = (Join-Path $Script:InstallPath "\RegistryChanges\Snapshots\SnapshotOld")
    
        if(Test-Path $OldPath){
            Remove-Item $OldPath -Force -Recurse
        }
        if(Test-Path $NewPath){
            Write-Host "New Snapshot becomes old Snapshot"
            Rename-Item $NewPath $OldPath -Force
        }

    }

    function Set-BISFLink {
        if(!(Test-Path "$Script:InstallPath\ITGLUE_Masterimage.ps1")){
            # Masterimage in Scriptpath hinzufügen
            Write-Host "Adding Masterimage Script to " $Script:InstallPath
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Schnagl/MasterimageDoku/main/ITGLUE_Masterimage.ps1" -OutFile ("$Script:InstallPath\" + "ITGLUE_Masterimage.ps1")  
        }


        if(Test-Path "C:\Program Files (x86)\Base Image Script Framework (BIS-F)"){
            # Autorun zu BIS-F hinzufügen
            write-Host "BISF exists - Creating Link"
            $BISFStart = @'
            & "C:\ProgramData\ITGlueMasterimage\ITGLUE_Masterimage.ps1"
'@
            $BISFStart > "C:\Program Files (x86)\Base Image Script Framework (BIS-F)\Framework\SubCall\Preparation\Custom\Masterimage_Dokumentation.ps1"

        }
        else{
            write-Host "BISF does not exists"

        }

    }
    function Update-GUIElements{
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
#--------------------------------------------------------[Functions]--------------------------------------------------------
#---------------------------------------------------------[Actions]---------------------------------------------------------
#region Action Definitions
    $ButtonSave_Click = {
        $Script:ITGlueOrgID = $TextBoxOrgID.text
        $Script:WebhookURL = $TextBoxWebhook.text
        $Script:Customers = $RichTextBoxCustomerInput.Lines
        write-host "ORGID:" + $Script:ITGlueOrgID
    
        $FormFirstRun.Close()
        #$FormA1.ShowDialog()
    } 
    $ButtonUpload_Click = {
        $FlexassetBody = Get-CustomFlexAssetBody
        Invoke-Webhook -FlexAssetBody $FlexAssetBody -FlexAssetName $FlexAssetName -ITGlueOrgID $Script:ITGlueOrgID -FieldName "hostname"
    
        $FormA1.Close()
        Set-PassInfo
        if(!$DeactivateBISF){
            Set-BISFLink 
        }

        
    }
    $ButtonCancel_Click ={
        $Script:BreakScript = $true
    }
    $TableLayoutPanel1_Paint = {
    }
    $FlowLayoutPanel1_Paint = {
    }
    $Label1_Click = {
    }
    $Form1_Load = {

    
        ##Costumers hinzufügen
        Foreach($Item in $Script:Customers){
            $Costumers += $Item
            $ComboBoxFirma.items.add($Item)
        }
        #$ComboBoxFirma.SelectedItem = $Costumers[0]

    }
#endregion
#---------------------------------------------------------[Actions]---------------------------------------------------------
#---------------------------------------------------------[Script]---------------------------------------------------------
#region Script
#1  Check ob eine neue Version verfügbar ist 
    ## Check New Version
    Get-NewVersion

#2  Check ob alle Programmteile vorhanden sind 
    Invoke-ProgramParts

#3 Alten Snapshot entfernen
    #Remove-OldRegistryKey #0802

#4  Check ob LastPass gefüllt ist oder dies der erste Durchlauf ist 
    #Lastpass Infos abrufen & Check ob Script schon einmal gelaufen ist
    $LastPass = Get-LastPassInfo
    if($NULL -eq $LastPass){
        $FirstRun   	    = $true
    }
    else{
        $FirstRun   	    = $false
    }

    #FirstRunCheck
    if($FirstRun){
        Get-FirstRegSnap
        $LastPassDate = Get-Date "01.01.1900"
    }
    else{
        #Nicht erster Durchgang
        #Variablen beschreiben
        $Script:ITGlueOrgID = $LastPass.ITGlueOrgID
        $LastPassDate       = $LastPass.PassDate
        $LastPassDate       = Get-Date $LastPassDate
        $Script:Customers   = $LastPass.Customers -split(",")
        $Script:WebhookURL  = $LastPass.WebhookURL
        $DeactivateGUI      = [System.Convert]::ToBoolean($Lastpass.DeactivateGUI)
        $DeactivateBISF     = [System.Convert]::ToBoolean($Lastpass.DeactivateBISF)
        $DeactivateSoftware = [System.Convert]::ToBoolean($Lastpass.DeactivateSoftware)
        $DeactivatePatches  = [System.Convert]::ToBoolean($Lastpass.DeactivatePatches)
        $DeactivateRegistry = [System.Convert]::ToBoolean($Lastpass.DeactivateRegistry)
    }

#5 GUIs vorbereiten
    if(!$DeactivateGUI){
        Add-Type -AssemblyName System.Windows.Forms
        .(Join-Path $Script:InstallPath '\ITGLUE_Masterimage_GUI.ps1')
        .(Join-Path $Script:InstallPath '\ITGLUE_Masterimage_FirstRunGUI.ps1')
    
        #Bilder in GUI laden
        $PictureBoxFirstRun.ImageLocation = $Script:InstallPath+"\EDVBV_LOGO.png" 
        $FormFirstRun.CancelButton        = $ButtonCancel
        $FormFirstRun.Icon                = New-Object system.drawing.icon ($Script:InstallPath+"\EDVBV_ICON.ico")
        $PictureBox1.ImageLocation        = $Script:InstallPath+"\EDVBV_LOGO.png"
        $FormA1.CancelButton              = $ButtonCancel
        $FormA1.Icon                      = New-Object system.drawing.icon ($Script:InstallPath+"\EDVBV_ICON.ico")
    }
    #GUI laden

#6 First Run
    if($FirstRun){
        write-host "First Run"
        if($DeactivateGUI){
            #Werte abfragen
            write-host "GUI deactivated"
            write-host "Please insert the values"

            $Script:ITGlueOrgID = Read-Host "ITGlueOrgID"
            $Script:WebhookURL  = Read-Host "WebhookURL" 
            $Script:Customers          = (Read-Host "Customers - Comma separated") -split(",")

        }
        else{
            #FirstRunGUI anzeigen
            write-host "First Run - GUI activated - Start FirstRunGUI"
            $FormFirstRun.ShowDialog()  
        }
    }


#7 Document Changes 
    if(!$Script:BreakScript){
        if(!$DeactivateSoftware){$Script:ChangesSoftware = Get-Changes-Software}
        if(!$DeactivatePatches){$Script:ChangesPatches = Get-Changes-Patches}
        <#if(!$DeactivateRegistry){
            $Script:ChangesRegistry = Get-Changes-Registry
            Get-Registry
        }#> #0802   
           
    }


#8 Process GUI
    if(!$Script:BreakScript){
        if($DeactivateGUI){
            #GUI Deaktiviert
            write-host "GUI deactivated - MainTask"
            $FlexassetBody = Get-CustomFlexAssetBody
            Invoke-Webhook -FlexAssetBody $FlexAssetBody -FlexAssetName $FlexAssetName -ITGlueOrgID $Script:ITGlueOrgID -FieldName "hostname"
            
            Set-PassInfo
            if(!$DeactivateBISF){
                Set-BISFLink 
            }
        }
        else{
            #GUI Aktiviert
            #MainGUI wird aufgerufen
            write-host "GUI activated - Start MainGUI"
            Update-GUIElements
            $FormA1.ShowDialog()
        }
    }

    
        


