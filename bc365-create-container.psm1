
# defined options
$availableOptions = @("OnPrem", "Sandbox")
$availableLanguages = @("au", "at", "be", "ca", "cz", "dk", "fi", "fr", "de", "gb", "is", "it", "mx", "nl", "nz", "no", "es", "se", "ch", "us", "na", "ru", "w1")

# functions
function Get-LicenceFile() {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Title = 'Select licence file'
    $OpenFileDialog.filter = 'Licence File|*.flf;*.bclicense'
    [void] $OpenFileDialog.ShowDialog()
    return $OpenFileDialog.filename
}

function Get-Artifacts($type, $language, $preview, $insider, $nextMajor) {
  
    if ($preview)
    {
        Get-BCArtifactUrl -storageAccount BcPublicPreview -type $type -country $language -select All
    } 
    if ($insider)
    {

        # get token from environment variable
        $sasToken = (get-childitem -Path Env:BcSasToken).Value

        if ($nextMajor)
        {
            Get-BCArtifactUrl -country $language -select NextMajor -sasToken $sasToken
        }
        else
        {
            Get-BCArtifactUrl -country $language -select NextMinor -sasToken $sasToken
        }
    }
    else {
        Get-BCArtifactUrl -type $type -country $language -select All        
    }
}

function Get-Folder($initialDirectory) {
    [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowserDialog.RootFolder = 'MyComputer'
    if ($initialDirectory) { $FolderBrowserDialog.SelectedPath = $initialDirectory }
    [void] $FolderBrowserDialog.ShowDialog()
    return $FolderBrowserDialog.SelectedPath
}

function Select-Type($type) {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Select type'
    $form.Size = New-Object System.Drawing.Size(380, 220)
    $form.StartPosition = 'CenterScreen'
    $form.FormBorderStyle = 'FixedDialog'

    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Location = New-Object System.Drawing.Point(10, 10)
    $listBox.Size = New-Object System.Drawing.Size(340, 130)
    #$listBox.Height = 200

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(190, 145)
    $okButton.Size = New-Object System.Drawing.Size(75, 23)
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $okButton
    $form.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(265, 145)
    $cancelButton.Size = New-Object System.Drawing.Size(75, 23)
    $cancelButton.Text = 'Cancel'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $cancelButton
    $form.Controls.Add($cancelButton)

    $index = 0
    foreach ($option in $availableOptions) {
        [void] $listBox.Items.Add($option)
        if ($option -eq $type) {
            $listBox.SetSelected($index, $true)
        }
        $index++
    }

    $form.Controls.Add($listBox)
    $form.Topmost = $true
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $x = $listBox.SelectedItem
        return $x
    }
}

function Select-Language($type) {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Select language'
    $form.Size = New-Object System.Drawing.Size(380, 220)
    $form.StartPosition = 'CenterScreen'
    $form.FormBorderStyle = 'FixedDialog'

    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Location = New-Object System.Drawing.Point(10, 10)
    $listBox.Size = New-Object System.Drawing.Size(340, 130)
    #$listBox.Height = 200

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(190, 145)
    $okButton.Size = New-Object System.Drawing.Size(75, 23)
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $okButton
    $form.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(265, 145)
    $cancelButton.Size = New-Object System.Drawing.Size(75, 23)
    $cancelButton.Text = 'Cancel'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $cancelButton
    $form.Controls.Add($cancelButton)

    $index = 0
    foreach ($option in $availableLanguages) {
        [void] $listBox.Items.Add($option)
        if ($option -eq $type) {
            $listBox.SetSelected($index, $true)
        }
        $index++
    }

    $form.Controls.Add($listBox)
    $form.Topmost = $true
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $x = $listBox.SelectedItem
        return $x
    }
}

function Select-Artifact($artifacts) {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Select artifact'
    $form.Size = New-Object System.Drawing.Size(380, 220)
    $form.StartPosition = 'CenterScreen'
    $form.FormBorderStyle = 'FixedDialog'

    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Location = New-Object System.Drawing.Point(10, 10)
    $listBox.Size = New-Object System.Drawing.Size(340, 130)
    #$listBox.Height = 100

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(190, 145)
    $okButton.Size = New-Object System.Drawing.Size(75, 23)
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $okButton
    $form.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(265, 145)
    $cancelButton.Size = New-Object System.Drawing.Size(75, 23)
    $cancelButton.Text = 'Cancel'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $cancelButton
    $form.Controls.Add($cancelButton)

    $index = 0

    foreach ($artifact in $artifacts) {
        [void] $listBox.Items.Add($artifact)
        $index++
    }

    $form.Controls.Add($listBox)
    $form.Topmost = $true
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $x = $listBox.SelectedItem
        return $x
    }
}

function Start-BCContainerBuild($artifactUrl, $name, $auth, $ssl, $includeCSide, $premiumPlan, $insider, $uploadLicense, $importTestTookit) {
    $tempPath = Get-Folder

    Download-Artifacts -artifactUrl ($artifactUrl) -includePlatform
    $containername = $name
    $containerBasePath = $tempPath + "\" + $containername
    If ((Test-Path $containerBasePath) -eq $False) {
        New-Item -Path $containerBasePath -ItemType "directory" | Out-Null
    }

    $sslCertLocation = '';
    if ($ssl) {
        $sslCertLocation = 'http://' + $containername + ':8080/certificate.cer'
        $sslFileLocation = $containerBasePath + '\certificate.cer'
    }

    # Build params
    $parameters = @{
        '-containername' = $containername
    }

    $parameters['-accept_eula'] = $true
    $parameters['-updateHosts'] = $true
    $parameters['-assignPremiumPlan'] = $premiumPlan
    $parameters['-dns'] = '8.8.8.8'
    
    if ($uploadLicense)
    {
        $license = Get-LicenceFile $defaultLicenceFolder
        $parameters['-licenseFile'] = $license
    }

    if ($importTestTookit)
    {
        $parameters['-includeTestToolkit'] = $true
    }


    $parameters['-artifactUrl'] = $artifactUrl
    $parameters['-auth'] = $auth
    $parameters['-useSSL'] = $ssl
    $parameters['-includeCSide'] = $includeCSide
    if ($auth = 'NavUserPassword'){
        $credential = Get-Credential -Message 'Please enter credentials for the container.'
        $parameters['-Credential'] = $credential
    }

    Measure-command {

        New-BCContainer @parameters     

        if ($ssl) {
            Write-Output "Getting the SSL Certificate"
            $client = new-object System.Net.WebClient
            $client.DownloadFile($sslCertLocation, $sslFileLocation)

            Write-Output "Installing the SSL Certificate into the Local Machine Trusted Store"
            Import-Certificate -FilePath $sslFileLocation -CertStoreLocation 'Cert:\LocalMachine\Root' -Verbose
        }
    }
}

function New-BC365Container() {

    param (
        [Parameter(Mandatory = $true)]
        [string]$ContainerName,

        [ValidateSet("Windows", "NavUserPassword")]
        [string]$Auth = "Windows",

        [bool]$SSL = $false,
 
        [bool]$CSide = $false,
 
        [bool]$Preview = $false,
 
        [bool]$Insider = $false,
        
        [bool]$NextMajor = $true,

        [bool]$PremiumPlan = $false,

        [bool]$UploadLicense = $false,
        
        [bool]$ImportTestTookit = $false

    )

    $originalColour = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = "DarkGreen"
    Write-Output "New-BC365Container - Version 0.0.9"
    $host.ui.RawUI.ForegroundColor = $originalColour

    # Variables
    $defaultLanguage = 'gb'
    $defaultType = 'OnPrem'

    if (($preview) -and ($insider)) {
        Write-Output "Preview and Insider are mutually exclusive. Please select only one."
        return $null
    }
    
    # Select type
    if ($Insider)
    {
        $selectedType = 'Sandbox'
    }
    else {
        $selectedType = Select-Type $defaultType
    }

    if ($null -eq $selectedType) {
        Write-Output "Aborted... type not defined"
    }
    else {

        # select language
        $selectedLanguage = Select-Language $defaultLanguage
        if ($null -eq $selectedLanguage) {
            Write-Output "Aborted... language not defined"
        }
        else {
            # get the available artifacts for type and language
            $availableArtifacts = Get-Artifacts $selectedType $selectedLanguage $Preview $Insider $NextMajor
            if ($null -eq $availableArtifacts) {
                Write-Output "Aborted... artifacts not found"
            }
            else {
                # select the artifact you want
                $selectedArtifact = Select-Artifact $availableArtifacts
                if ($null -eq $selectedArtifact) {
                    Write-Output "Aborted... artifact not specified"
                }
                else {
                    Start-BCContainerBuild $selectedArtifact $ContainerName $Auth $SSL $CSide $PremiumPlan $Insider $UploadLicense $ImportTestTookit
                }
            }
        }
    }

}

# New-BC365Container -ContainerName 'test' -Auth 'NavUserPassword' -SSL $False -CSide $true