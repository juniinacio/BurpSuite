# BurpSuite

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/juniinacio/BurpSuite/blob/master/LICENSE)
[![Documentation - BurpSuite](https://img.shields.io/badge/Documentation-BurpSuite-blue.svg)](https://github.com/juniinacio/BurpSuite/blob/master/README.md)
[![PowerShell Gallery - BurpSuite](https://img.shields.io/badge/PowerShell%20Gallery-BurpSuite-blue.svg)](https://www.powershellgallery.com/packages/BurpSuite)
[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1-blue.svg)](https://github.com/PowerShell/PowerShell)

## Introduction

BurpSuite is a PowerShell module with commands for managing [BurpSuite Enterprise](https://portswigger.net/burp/enterprise).

Documentation of the cmdlets can be found in the [docs README](https://github.com/juniinacio/BurpSuite/blob/master/docs/en-US/about_BurpSuite.help.md) or using `Get-Help BurpSuite` once the module is installed.

## Requirements

- Windows PowerShell 5.1 or newer.
- PowerShell Core.

## Installation

Install this module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/BurpSuite).

```PowerShell
Install-Module -Name BurpSuite
```

## Change Log

[Change Log](CHANGELOG.md)

## Pipeline Status

You can review the status of every BurpSuite pipeline below.

|         Pipeline                    |             Status           |
|-------------------------------------|------------------------------|
| Production                          | [![Build Status](https://dev.azure.com/juniinacio/BurpSuite/_apis/build/status/BurpSuite?branchName=master)](https://dev.azure.com/juniinacio/BurpSuite/_build/latest?definitionId=13&branchName=master) |

The build for BurpSuite is run on Linux and Windows to ensure there are no casing or other platform specific issues with the code. On each platform unit tests are run to ensure the code runs on all platforms and without issues. During pull request builds the module is also installed both on Windows and Linux and tested using integration tests against BurpSuite Enterprise before changes are pushed to the master branch.

## Building Module

### How to build locally

To run build the script `build.ps1`. The script has the following parameters:

* `-Task '<Task Name>'`: Specifies the task you wish to run, default is Test, see [build.ps1](build.ps1) or alternatively run `.\build.ps1 -Help`.
* `-Bootstrap`: By default the build will not install dependencies unless this switch is used.
* `-Help`: Lists al tasks available for the building.

Below are some examples on how to build the module locally. It is expected that your working directory is at the root of the repository.

Builds the module, runs unit tests and also builds the help.
```PowerShell
.\build.ps1
```

Builds the module, installs needed dependencies, runs unit tests and also builds the help.
```PowerShell
.\build.ps1 -Bootstrap
```

## Using Module

### Getting started with BurpSuite

Before you can start using the cmdlets in this module you will need to create a API key in the BurpSuite Enterprise UI. After getting the API key the first step is to connect the module with BurpSuite, this can be done using the following cmdlet.
```powershell
Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"
```

After connecting the module with your BurpSuite Enterprise server, you can do a number of actions using the cmdlets available in this module. To list available commands in the module use `Get-Command -Module BurpSuite`.

To list sites and folder on BurpSuite use the following command.

```powershell
Get-BurpSuiteSiteTree
```

To list al scan configurations.
```powershell
Get-BurpSuiteScanConfiguration
```

To create a new site.
```powershell
$scope = [PSCustomObject]@{
    IncludedUrls = @("http://example.com")
}
New-BurpSuiteSite -Name "www.example.com" -Scope $scope -ScanConfigurationIds '1232asdf23234f'
```

## Contributors

[Guidelines](.github/CONTRIBUTING.md)

## Maintainers

- [Juni Inacio](https://github.com/juniinacio) - [@Jinac81](https://twitter.com/Jinac81)

## Kudos

Kudos goes to the following people for inspiring me on building PowerShell modules.

- [Donovan Brown](https://github.com/darquewarrior) - [@DonovanBrown](https://twitter.com/DonovanBrown)

## License

This project is [licensed under the MIT License](LICENSE).
