<#
Zweck: IT-Glue Skript EDV-BV GmbH
Ersteller: Christian Schnagl

#>

#Requires -Version 5.0
##Requires IGEL UMS6

### Anpassungen:
# 20122021  CRSC    Basics
# 20220103  CRSC    Anpassungen Upload, Eingabe

# Beispiel 1:

#################################################################################################################
    ########################### Option 1 - Powershell ###########################
    param(
        $ITGlueOrgID    = $NULL,    # Global im Script
        $CSV            = $NULL,    # Global im Script
        $UMSAdress      = $NULL,    # Per CSV / Direct
        $User           = $NULL,    # Per CSV / Abfrage Powershell
        $Password       = $NULL     # Per CSV / Abfrage Powershell
    )
    ########################### Option 2 - Azure Pipeline ###########################
        if($NULL -ne ${env:ITGlueApiKEY})   {$ITGlueApiKEY  = ${env:ITGlueApiKEY}}
        if($NULL -ne ${env:ITGlueOrgID})    {$ITGlueOrgID   = ${env:ITGlueOrgID}}
        if($NULL -ne ${env:ORGID})          {$ITGlueOrgID   = ${env:ORGID}}
        if($NULL -ne ${env:CSV})            {$CSV           = ${env:CSV}}
        if($NULL -ne ${env:UMSAdress})      {$UMSAdress     = ${env:UMSAdress}}
        if($NULL -ne ${env:User})           {$User          = ${env:User}}
        if($NULL -ne ${env:Password})       {$Password      = ${env:Password}}

    ########################### Option 3 - Abfrage ###########################
        #Werte die nicht per CSV übergeben werden können
        if($Null -eq $ITGlueOrgID){
            $ITGlueOrgID = Read-Host "ITGlueOrgID"
        }
        #Werte die per CSV übergeben werden können
        IF([string]::IsNullOrWhiteSpace($CSV)){
            if($Null -eq $UMSAdress){
                $UMSAdress = Read-Host "UMSAdress"
            }
            if($Null -eq $User){
                $User = Read-Host "User"
            }    
            if($Null -eq $Password){
                $securepass = Read-Host "Password" -AsSecureString
            }        
        }



    ########################### Environment beschreiben - CSV verwenden ############################>
    IF([string]::IsNullOrWhiteSpace($CSV)){
        #ADC - Variable befüllen wenn CSV nicht gesetzt wurde
        $UMSs = New-Object PSCustomObject
        $UMSs | Add-Member -type NoteProperty -name UMSAdress -Value $UMSAdress
        $UMSs | Add-Member -type NoteProperty -name User -Value $User   
        $UMSs | Add-Member -type NoteProperty -name Password -Value $Password
        $UMSs | Add-Member -type NoteProperty -name securepass -Value $securepass
    }
    else{
        $UMSs = Import-Csv $CSV -Delimiter ";"
    }
    


    ########################### ITGlue Infos ###########################
    $APIEndpoint = "https://api.eu.itglue.com"
    $FlexAssetName = "IGEL UMS"


    ########################### Azure Pipeline Check ###########################
    # Check ob Script durch Azure gestartet wurde 
    if($NULL -ne ${env:TF_BUILD}){
        write-host "Azure Pipeline wird verwendet"
        $AzurePipeline = $True
    }
    else{
        write-host "Azure Pipeline wird nicht verwendet"
        $AzurePipeline = $False
    }
    if($NULL -ne $ITGlueApiKEY){
        Write-Host "ITGLUE API Key ist gesetzt"
        Write-Host "ITGLUE direkt Upload aktiviert"
        write-host "Webhook deaktiviert"
        $ITGlueUpload = $True
        $WebhookUpload = $False
    }
    else{
        Write-Host "ITGLUE API Key ist nicht gesetzt"
        Write-Host "ITGLUE direkt Upload deaktiviert"
        write-host "Webhook aktiviert"
        $ITGlueUpload = $False
        $WebhookUpload = $True
    }



    # TLS 1.2 Aktivieren
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12



#################################################################################################################
function Install-PSModule ($m) {
    if (Get-Module -ListAvailable -Name $m ) {
        Import-Module -Name $m
        
        Write-Host "Module "  $m " exists" -ForegroundColor green
    } 
    else {
        Write-Host "Module " $m " does not exist and will be installed" -ForegroundColor yellow
        Install-Module $m -Verbose -Scope CurrentUser -Confirm:$false -Force
    }
}
    
function Invoke-Webhook{
    param(
      $FlexAssetBody,
      $ITGlueOrgID,
      $FlexAssetName,
      $FieldName #Feldname der überprüft werden soll - z.B. Hostname
    )
    Write-Host "Sending to Webhook"
    $WebhookURL = 'https://1c526335-77da-4dac-ba6c-295357be5a2e.webhook.dewc.azure-automation.net/webhooks?token=YKai9s%2fr7%2bTXEtnW2%2faweqWZObsryFXkKdmpkHZoEXU%3d'
    $UploadJSON = ConvertTo-Json -InputObject $FlexAssetBody
    $header = @{ 
      ITGlueOrgID   = $ITGlueOrgID 
      FlexAssetName = $FlexAssetName
      FieldName    = $FieldName      
    }
    $response = Invoke-RestMethod -Method post -Uri $WebhookURL -Body $UploadJSON -Headers $header
  }
function Invoke-ITGlueAPI{
    param(
        $ITGlueOrgID,
        $FlexAssetName,
        $FlexAssetBody,
        $Fieldname
        
    )
    write-host "FlexassetName $FlexAssetName"
    write-host "ITGlueOrgID $ITGlueOrgID"
    $Fieldvalue = $FlexAssetBody.attributes.traits.$Fieldname

    $FilterID = (Get-ITGlueFlexibleAssetTypes -filter_name $FlexAssetName).data

    $ExistingFlexAsset = (Get-ITGlueFlexibleAssets -filter_flexible_asset_type_id $($FilterID.ID) -filter_organization_id $ITGlueOrgID).data | Where-Object { $($_.attributes.traits.$Fieldname) -eq $($Fieldvalue)}
    
    #$ExistingFlexAsset.attributes.traits.psobject.Properties.name

    # ITGlue Reupload

    if ($ExistingFlexAsset) { 
        $diff = compare-object $($FlexAssetBody.attributes.traits.keys) ($ExistingFlexAsset.attributes.traits.psobject.Properties.name) #Fehler in Azure
        #$diff = compare-object $($FlexAssetBody.attributes.traits.psobject.Properties.name) ($ExistingFlexAsset.attributes.traits.psobject.Properties.name)
        $additionalattributes = @()
        $additionalattributes += $diff | Where-Object sideindicator -eq "=>" | Select-Object -ExpandProperty InputObject

        foreach ($additionalattribute in $additionalattributes) {
            $FlexAssetBody.attributes.traits.add("$additionalattribute", "$($ExistingFlexAsset.attributes.traits.$additionalattribute)")
        }
    }

    # Ende Reupload
    #If the Asset does not exist, we edit the body to be in the form of a new asset, if not, we just upload.
    if (!$ExistingFlexAsset) {
        $FlexAssetBody.attributes.add('organization-id', $ITGlueOrgID)
        $FlexAssetBody.attributes.add('flexible-asset-type-id', $($filterID.ID))
        write-host "  Creating $FlexAssetName in IT-Glue organisation $ITGlueOrgID" 

        New-ITGlueFlexibleAssets -data $FlexAssetBody
    }
    else {
        Write-Host "Updating Flexible Asset"
        
        $ExistingFlexAsset = $ExistingFlexAsset[-1]
        Set-ITGlueFlexibleAssets -id $ExistingFlexAsset.id  -data $FlexAssetBody
    }
    return 

}

function get-NextDirectory{
    param(
        $DeviceDirectorys,
        $ID
    )

    $UMSDeviceDirectory = Get-UMSDeviceDirectory -id $ID

    if($UMSDeviceDirectory.ParentId -isnot "-1"){
        

    }

    return $UMSDeviceDirectory

}

function InventorizeIGELUMSDevices{
    #Funktion ausgelagert da ITGLUE Upload Limit
    #Devices
    write-Host "process Devices"
    $DeviceDirectoryColl = Get-UMSDeviceDirectory 
    $DeviceDirectorys = Get-UMSDirectoryRecursive -Id "-1" -DirectoryColl $DeviceDirectoryColl



    $UMSDevices = Get-UMSDevice -Filter details
    $UMSDeviesNew = @()
    $DirectoryPaths = @()
    

    foreach($UMSDevice in $UMSDevices){

        $UMSDeviceDirectory = Get-UMSDeviceDirectory -id $UMSDevice.ParentID -WarningAction SilentlyContinue

        if($DirectoryPaths.ID -match $UMSDeviceDirectory.ID ){
            #Ok, Directory existiert bereits
           
            $UMSDevice | Add-Member -MemberType NoteProperty -Name 'DirectoryString' -Value $(($DirectoryPaths | where-object {$_.ID -eq $UMSDeviceDirectory.ID}).DirectoryString)
            #$UMSDevice | Add-Member -Name 'New Property' -Type NoteProperty -Value 23

            #write-host "Extistiert"
        }
        else{
            $ParentDirectory = $UMSDeviceDirectory 
            $DirectoryString = $ParentDirectory.Name + "/"
            while($ParentDirectory.ParentId -notmatch "-1")
            {
                $ParentDirectory = Get-UMSDeviceDirectory -id $ParentDirectory.ParentId
                $DirectoryString = $ParentDirectory.Name + "/" + $DirectoryString 

            }
            $Directory = New-Object PSCustomObject
            $Directory | Add-Member -type NoteProperty -name ID -Value $UMSDevice.ParentID
            $Directory | Add-Member -type NoteProperty -name DirectoryString -Value $DirectoryString
            $DirectoryPaths += $Directory
            $UMSDevice | Add-Member -MemberType NoteProperty -Name 'DirectoryString' -Value $Directory.DirectoryString
        }

        

        # Single Device Upload
        <#
        $DeviceName = $UMSDevice.Name
        $DeviceDirectory = $UMSDevice.DirectoryString
        $DeviceInfosTechnical = $($UMSDevice | Select-Object ProductId, DeviceType, Mac, UnitId, OsType, BiosVersion | ConvertTo-Html -Fragment | Out-String)
        $DeviceInfosOther = $($UMSDevice | Select-Object Site, Comment, Department, CostCenter, AssetID, InServiceDate, SerialNumber | ConvertTo-Html -Fragment | Out-String)
        $DeviceFirmware = $(Get-UMSFirmware -id $UMSDevice.FirmwareId | Select-Object Product, Version | ConvertTo-Html -Fragment | Out-String)
        #$DeviceSystem = $($UMSDevice | Select-Object Site, Comment, Department, CostCenter, AssetID, InServiceDate, SerialNumber | ConvertTo-Html -Fragment | Out-String)


        $FlexAssetBodyDevice = 
        @{
            type       = 'flexible-assets'
            attributes = @{
                traits = @{
                    'name'                    = $DeviceName
                    'directory'               = $DeviceDirectory         
                    'technical-informations'  = $DeviceInfosTechnical         
                    'other-informations'      = $DeviceInfosOther   
                    'firmware'                = $DeviceFirmware     
                }
            }
        }

        if($WebhookUpload){
            #Invoke-Webhook -FlexAssetBody $FlexAssetBodyDevice -FlexAssetName "IGEL Device" -ITGlueOrgID $ITGlueOrgID -FieldName "name"
            write-warning "No Device Webhook Upload"
        }
        elseif(!$WebhookUpload){
            Invoke-ITGlueAPI -FlexAssetBody $FlexAssetBodyDevice -FlexAssetName "IGEL Device" -ITGlueOrgID $ITGlueOrgID -FieldName "name"
            #Create or Update Asset in IT Glue
        }

        #>
    
    }
    $UMSDevicesGroups = $UMSDevices | Group-Object -Property DirectoryString | Sort-Object -Property DirectoryString

    $DevicesHTML = ""
    foreach($UMSDevicesGroup in $UMSDevicesGroups){
        $DeviceGroupHTML = "<br>"
        $DeviceGroupHTML += "<p><b>$($UMSDevicesGroup.Name)</b> $($UMSDevicesGroup.Group.Count) Devices</p>"
        #$DeviceGroupHTML = "<p>In sum there are $($UMSDevicesGroup.Count) Devices</p>"
        $DeviceGroupHTML += $($UMSDevicesGroup.Group | Select-Object Name, ProductId, DeviceType | ConvertTo-Html -Fragment | Out-String)
        $DevicesHTML += $DeviceGroupHTML
    }

    #$DevicesHTML | out-file -FilePath "C:\Temp\test.htm"

    $FlexAssetBodyDevices = 
    @{
        type       = 'flexible-assets'
        attributes = @{
            traits = @{
                'hostname'              = $UMSAdress
                'devices'               = $DevicesHTML         
            }
        }
    }

    if($WebhookUpload){
        Invoke-Webhook -FlexAssetBody $FlexAssetBodyDevices -FlexAssetName $FlexAssetName -ITGlueOrgID $ITGlueOrgID -FieldName "hostname"
    }
    elseif($ITGlueUpload){
        Invoke-ITGlueAPI -FlexAssetName $FlexAssetName -ITGlueOrgID $ITGlueOrgID -FlexAssetBody $FlexAssetBodyDevices -FieldName "hostname"
        #Create or Update Asset in IT Glue
    }

}

function InventorizeIGELUMS {

    #UMS Basics
    write-Host "process Basics"
    $UMSStatus = Get-UMSStatus | Select-Object Server,BuildNumber,RmGuiServerVersion,DerbyVersion,ActiveMqVersion 
    $UMSStatusHTML = $UMSStatus | ConvertTo-Html -Fragment | Out-String
    
    #Firmware 
    write-Host "process Firmware"
    $UMSFirmware = Get-UMSFirmware | select-object Product, Id, Version, FirmwareType
    $UMSFirmwareHTML = $UMSFirmware | ConvertTo-Html -Fragment | Out-String


    #Profiles
    write-Host "process Profiles"
    $UMSProfiles = Get-UMSProfile |  Select-Object Name, id, firwareid, IsMasterProfile, OverridesSessions
    $UMSProfilesHTML = $UMSProfiles | ConvertTo-Html -Fragment | Out-String


    #ProfileAssignments
    write-Host "process Profile Assignments"
    $DirectAssignments = @()
    $DirAssignments = @()
    foreach($UMSProfile in $UMSProfiles){
        
        $Receivers = Get-UMSProfileAssignment -Id $UMSProfile.Id
        $DirReceivers = Get-UMSProfileAssignment -Id $($UMSProfile.Id) -Directory
        if($NULL -ne $Receivers){
            $DevicesString = "" 
            foreach($Receiver in $Receivers){
                $DevicesString += $((Get-UMSDevice -Id $Receiver.ReceiverId).Name)
                $DevicesString += ";" 
                
            }
                $DevicesString = $DevicesString.Substring("0",$DevicesString.Length -1)
                $DirectAssignment = New-Object PSCustomObject
                $DirectAssignment | Add-Member -type NoteProperty -name "Profile" -Value $UMSProfile.Name
                $DirectAssignment | Add-Member -type NoteProperty -name "Devices" -Value $DevicesString
                $DirectAssignments += $DirectAssignment
        }   
        if($NULL -ne $DirReceivers){
            $DirString = "" 
            foreach($DirReceiver in $DirReceivers){
                $Dir = $((Get-UMSDeviceDirectory -Id $DirReceiver.ReceiverId -WarningAction SilentlyContinue).Name)
                if($Null -ne $Dir){
                    $DirString += $Dir
                    $DirString += ";" 
                }

                
            }
                $DirString = $DirString.Substring("0",$DirString.Length -1)
                $DirAssignment = New-Object PSCustomObject
                $DirAssignment | Add-Member -type NoteProperty -name "Profile" -Value $UMSProfile.Name
                $DirAssignment | Add-Member -type NoteProperty -name "Directorys" -Value $DirString
                $DirAssignments += $DirAssignment
        }  

    }
            
    $DirectAssignments = $DirectAssignments |Sort-Object -Property Profile
    $DirAssignments = $DirAssignments |Sort-Object -Property Profile 



    $AssignmentsHTML = ""
    $AssignmentsHTML += "<br>"
    $AssignmentsHTML += "<p><b>Direct Assignments</b></p>"
    $AssignmentsHTML += $($DirectAssignments | ConvertTo-Html -Fragment | Out-String)
    $AssignmentsHTML += "<br>"
    $AssignmentsHTML += "<p><b>Directory Assignments</b></p>"
    $AssignmentsHTML += $($DirAssignments | ConvertTo-Html -Fragment | Out-String)
    

    $UMSDescription = "Automatische Documentation der Igel UMS"
    
    $FlexAssetBody = 
    @{
        type       = 'flexible-assets'


        attributes = @{
    
            traits = @{

                'hostname'              = $UMSAdress
                'description'           = $UMSDescription
                'status'                = $UMSStatusHTML   
                'firmware'              = $UMSFirmwareHTML
                'profiles'              = $UMSProfilesHTML
                'profile-assignments'   = $AssignmentsHTML
                #'devices'               = $UMSDevices         
            }
        }
    }


    #$FlexAssetBody.attributes.traits

    if($WebhookUpload){
        Invoke-Webhook -FlexAssetBody $FlexAssetBody -FlexAssetName $FlexAssetName -ITGlueOrgID $ITGlueOrgID -FieldName "hostname"
    }
    elseif($ITGlueUpload){
        Invoke-ITGlueAPI -FlexAssetName $FlexAssetName -ITGlueOrgID $ITGlueOrgID -FlexAssetBody $FlexAssetBody -FieldName "hostname"
        #Create or Update Asset in IT Glue
    }
}

#Script Part

    Install-PSModule PSIGEL
    if($ITGlueUpload){
        #Install Modules
        Install-PSModule ITGlueAPI

        #Connect to IT Glue API
        Add-ITGlueBaseURI -base_uri $APIEndpoint
        Add-ITGlueAPIKey $ITGlueApiKEY
    }




foreach($UMS in $UMSs){
    $curuser = $UMS.User
    if($NULL -eq $UMS.securepass){
        #Wenn noch kein SecurePass wert übergeben wurde, SecurePass aus $UMS.Password erstellen
        $curpass= $UMS.Password
        $securepass=ConvertTo-SecureString $curpass -AsPlainText -force
    }
    else{
        $securepass=$UMS.securepass
    }
    $cred=new-object system.management.automation.PSCredential $curuser,$securepass

    $PSDefaultParameterValues = @{
      '*-UMS*:Credential'   = $cred
      '*-UMS*:Computername' = $UMSAdress
    }

    $PSDefaultParameterValues += @{
      '*-UMS*:WebSession' = New-UMSAPICookie
    }
      
    InventorizeIGELUMS
    InventorizeIGELUMSDevices
}
