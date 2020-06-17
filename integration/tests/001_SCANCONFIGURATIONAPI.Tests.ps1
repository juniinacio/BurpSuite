Set-StrictMode -Version Latest

##############################################################
#     THESE TEST ARE DESTRUCTIVE. USE A CLEAN BURPSUITE.     #
##############################################################
# Before running these tests you must set the following      #
# Environment variables.                                     #
# $env:BURPSUITE_APIKEY = BurpSuite Enterprise API key       #
# $env:BURPSUITE_APIVERSION = v1                             #
# $env:BURPSUITE_URL = Url to BurpSuite Enterprise           #
##############################################################
#     THESE TEST ARE DESTRUCTIVE. USE A CLEAN BURPSUITE.     #
##############################################################

Describe 'Scan Configuration API' -Tag 'CD' {
    BeforeAll {
        $BURPSUITE_APIKEY = $env:BURPSUITE_APIKEY
        $BURPSUITE_APIVERSION = $env:BURPSUITE_APIVERSION
        $BURPSUITE_URL = $env:BURPSUITE_URL

        Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL
    }

    Context 'New-BurpSuiteScanConfiguration' {
        BeforeEach {
            $name = 'BurpSuiteCreateScanConfigurationTest'
        }

        It 'should create scan configuration' {
            # Arrange
            $filePath = Join-Path -Path $PSScriptRoot -ChildPath 'mocks\scan_configuration.json'

            # Act
            New-BurpSuiteScanConfiguration -Name $name -FilePath $filePath

            # Assert
            Get-BurpSuiteScanConfiguration -Fields id, name, scan_configuration_fragment_json | Where-Object { $_.name -eq $name } | Should -Not -BeNullOrEmpty
        }

        AfterEach {
            Get-BurpSuiteScanConfiguration -Fields id | Where-Object { $_.name -eq $name } | Remove-BurpSuiteScanConfiguration -Confirm:$false
        }
    }

    Context 'Remove-BurpSuiteScanConfiguration' {
        BeforeEach {
            $name = 'BurpSuiteRemoveScanConfigurationTest'
        }

        It 'should remove scan configuration' {
            # Arrange
            $filePath = Join-Path -Path $PSScriptRoot -ChildPath 'mocks\scan_configuration.json'
            New-BurpSuiteScanConfiguration -Name $name -FilePath $filePath

            # Act
            Get-BurpSuiteScanConfiguration -Fields id | Where-Object { $_.name -eq $name } | Remove-BurpSuiteScanConfiguration -Confirm:$false

            # Assert
            Get-BurpSuiteScanConfiguration -Fields id | Where-Object { $_.name -eq $name } | Should -BeNullOrEmpty
        }

        AfterEach {
            Get-BurpSuiteScanConfiguration -Fields id, built_in | Where-Object { $_.name -eq $name } | Remove-BurpSuiteScanConfiguration -Confirm:$false
        }
    }
}
