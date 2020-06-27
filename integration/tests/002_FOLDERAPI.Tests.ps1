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

Describe 'Folder API' -Tag 'CD' {
    BeforeAll {
        $BURPSUITE_APIKEY = $env:BURPSUITE_APIKEY
        $BURPSUITE_APIVERSION = $env:BURPSUITE_APIVERSION
        $BURPSUITE_URL = $env:BURPSUITE_URL

        Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL
    }

    Context 'New-BurpSuiteFolder' {
        BeforeEach {
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
        }

        It 'should create folder' {
            # Arrange

            # Act
            New-BurpSuiteFolder -Name $name

            # Assert
            $folder = (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -eq $name }

            $folder | Should -Not -BeNullOrEmpty

            $folder.name | Should -Be $name
            $folder.parent_id | Should -Be 0
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -like "Pester - *" } | Remove-BurpSuiteFolder -Confirm:$false
        }
    }

    Context 'Rename-BurpSuiteFolder' {
        BeforeEach {
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
        }

        It 'should rename folder' {
            # Arrange
            $newName = 'Pester - {0}' -f [Guid]::NewGuid()
            New-BurpSuiteFolder -Name $name
            $folder = (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -eq $name }

            # Act
            Rename-BurpSuiteFolder -Id $folder.id -Name $newName

            # Assert
            $folder = (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -eq $newName }

            $folder | Should -Not -BeNullOrEmpty

            $folder.name | Should -Be $newName
            $folder.parent_id | Should -Be 0
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -like "Pester - *" } | Remove-BurpSuiteFolder -Confirm:$false
        }
    }

    Context 'Move-BurpSuiteFolder' {
        BeforeEach {
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
        }

        It 'should move folder' {
            # Arrange
            $newName = 'Pester - {0}' -f [Guid]::NewGuid()

            New-BurpSuiteFolder -Name $name
            $parentFolder = (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -eq $name }

            New-BurpSuiteFolder -Name $newName
            $folder = (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -eq $newName }

            # Act
            Move-BurpSuiteFolder -FolderId $folder.Id -ParentId $parentFolder.id

            # Assert
            $folder = (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -eq $newName }

            $folder | Should -Not -BeNullOrEmpty

            $folder.name | Should -Be $newName
            $folder.parent_id | Should -Be $parentFolder.Id
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).folders | Where-Object { ($_.name -like "Pester - *") -and ($_.parent_id -eq 0) } | Remove-BurpSuiteFolder -Confirm:$false
        }
    }
}
