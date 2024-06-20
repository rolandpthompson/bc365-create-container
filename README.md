# bc365-create-container

A PowerShell module to enable quick deployment of an docker Microsoft Dynamics 365 Business Central instance using artifacts.
Its simplifies the list by showing GUI style lists for language and version selection along with File and Folder dialogs for licence file (optional) and directory to store local files

## Requirements

You need to make sure you have the BcContainerHelper PowerShell module 

## Parameters


* `-ContainerName`: Name to be used for the container
* `-Auth`: Windows or NavUserPassword (default is Windows)
* `-SSL`: Defines if local SSL should be used (default is false)
* `-CSide`: Specifies if CSide client etc should be installed (default is false)
* `-Preview` : Specifies that we want to use the Public Preview artifacts (fault is false)
* `-Insider` : Specifies to get the insider version. Requies an ENVIRONMENT called BcSasToken with your insider token (fault is false)
* `-NextMajor` : Gets the next major version, otherwise the next minor version will be retrieved (default is true)
* `-PremiumPlan` : Enables the premium plan within the installation (default is false)
* `-UploadLicense` : Prompts for a licence file to upload (default is false)
* `-ImportTestTookit` : Imports the TestToolkit into the create container (default is false)


## Installation

```
Import-Module bc365-create-container
```

## Usage

Simplest usage is:

```
New-BC365Container -ContainerName *yourname* -Auth NavUserPassword
```

Recommended normal usage is

```
New-BC365Container -ContainerName *yourname* -Auth NavUserPassword
```

Recommended normal usage with the test toolkit is

```
New-BC365Container -ContainerName *yourname* -Auth NavUserPassword -ImportTestToolkit $true
```

Recommended for insider usage is

```
New-BC365Container -ContainerName test -Auth NavUserPassword -Insider $true
```

Recommended normal usage is (for public previews)

```
New-BC365Container -ContainerName *yourname* -SSL $true -Auth NavUserPassword -Preview $true
```

## Release Notes

### Version 0.0.9

Removed the prompt for a license by default (no longer required on newer versions)
Added new option to install the TestToolKit after container creation
Fixed issue with incorrect parameters being passed

### Version 0.0.8

Added options for insider, nextminor/nextmajor and premium plan

### Version 0.0.7

Added parameter for Public preview artifacts

### Version 0.0.6

Added parameters for SSL, CSide and authentication

### Version 0.0.5

Initial release
 