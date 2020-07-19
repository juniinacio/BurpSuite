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

        Get-BurpSuiteScanConfiguration -Fields id, name, built_in | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteScanConfiguration -Confirm:$false
    }

    Context 'New-BurpSuiteScanConfiguration' {
        BeforeEach {
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
        }

        It 'should create scan configuration' {
            # Arrange
            $filePath = Join-Path -Path $PSScriptRoot -ChildPath 'artifacts\scan_configuration.json'

            # Act
            New-BurpSuiteScanConfiguration -Name $name -FilePath $filePath

            # Assert
            $scanConfiguration = Get-BurpSuiteScanConfiguration -Fields id,name,scan_configuration_fragment_json | Where-Object { $_.name -eq $name }
            $scanConfiguration | Should -Not -BeNullOrEmpty
            $scanConfiguration.name | Should -Be $name
        }

        AfterEach {
            Get-BurpSuiteScanConfiguration -Fields id, name, built_in | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteScanConfiguration -Confirm:$false
        }
    }

    Context 'Remove-BurpSuiteScanConfiguration' {
        BeforeEach {
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
        }

        It 'should remove scan configuration' {
            # Arrange
            $filePath = Join-Path -Path $PSScriptRoot -ChildPath 'artifacts\scan_configuration.json'
            New-BurpSuiteScanConfiguration -Name $name -FilePath $filePath
            $scanConfiguration = Get-BurpSuiteScanConfiguration -Fields id,name | Where-Object { $_.name -eq $name }

            # Act
            $scanConfiguration | Remove-BurpSuiteScanConfiguration -Confirm:$false

            # Assert
            Get-BurpSuiteScanConfiguration -Fields id | Where-Object { $_.name -eq $name } | Should -BeNullOrEmpty
        }

        AfterEach {
            Get-BurpSuiteScanConfiguration -Fields id, name, built_in | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteScanConfiguration -Confirm:$false
        }
    }

    Context 'Update-BurpSuiteScanConfiguration' {
        BeforeEach {
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
        }

        It 'should update scan configuration' {
            # Arrange
            $filePath = Join-Path -Path $PSScriptRoot -ChildPath 'artifacts\scan_configuration.json'
            New-BurpSuiteScanConfiguration -Name $name -FilePath $filePath
            $scanConfiguration = Get-BurpSuiteScanConfiguration -Fields id,name | Where-Object { $_.name -eq $name }

            $newName = 'Pester - {0}' -f [Guid]::NewGuid()

            # Act
            Update-BurpSuiteScanConfiguration -Id $scanConfiguration.id -Name $newName -Confirm:$false

            # Assert
            $scanConfiguration = Get-BurpSuiteScanConfiguration -Fields id,name | Where-Object { $_.name -eq $newName }
            $scanConfiguration | Should -Not -BeNullOrEmpty
        }

        AfterEach {
            Get-BurpSuiteScanConfiguration -Fields id, name, built_in | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteScanConfiguration -Confirm:$false
        }
    }
}
