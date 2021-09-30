# bc365-create-container

A PowerShell module to enable quick deployment of an Onpremise Microsoft Dynamics 365 Business Central instance using artifacts.
Its simplifies the list by showing GUI style lists for language and version selection along with File and Folder dialogs for licence file and directory to store local files

## Requirements

You need to make sure you have the BcContainerHelper PowerShell module 

## Parameters


* `-ContainerName`: Name to be used for the container
* `-Auth`: Windows or NavUserPassword (default is Windows)
* `-SSL`: Defines if local SSL should be used (default is false)
* `-CSide`: Specifies if CSide client etc should be installed (default is false)
* `-Preview` : Specifies that we want to use the Public Preview artifacts (fault is false)

## Installation

```
Import-Module bc365-create-container
```

## Usage

Simplest usage is:

```
New-BC365Container -ContainerName *yourname*
```

Recommended normal usage is

```
New-BC365Container -ContainerName *yourname* -SSL $true -Auth NavUserPassword
```

Recommended normal usage is (for publis previews)

```
New-BC365Container -ContainerName *yourname* -SSL $true -Auth NavUserPassword -Preview $true
```

## Release Notes
### Version 0.0.7

Added parameter for Public preview artifacts

### Version 0.0.6

Added parameters for SSL, CSide and authentication

### Version 0.0.5

Initial release
 