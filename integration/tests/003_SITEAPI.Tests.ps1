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

Describe 'Site API' -Tag 'CD' {
    BeforeAll {
        $BURPSUITE_APIKEY = $env:BURPSUITE_APIKEY
        $BURPSUITE_APIVERSION = $env:BURPSUITE_APIVERSION
        $BURPSUITE_URL = $env:BURPSUITE_URL

        Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL
    }

    Context 'New-BurpSuiteSite' {
        BeforeEach {
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
        }

        It 'should create site' {
            # Arrange
            $scope = [PSCustomObject]@{
                IncludedUrls = @("https://pester.dev/")
                ExcludedUrls = @("https://pester.dev/login")
            }

            $emailRecipient = [PSCustomObject]@{ Email = "foo@pester.dev" }

            $applicationLogin = [PSCustomObject]@{
                Label      = "admin"
                Credential = (New-Object System.Management.Automation.PSCredential ("admin", $(ConvertTo-SecureString "ChangeMe" -AsPlainText -Force)))
            }

            # Act
            New-BurpSuiteSite -Name $name -Scope $scope -ScanConfigurationIds 'a469d9d4-20ee-4d99-b727-c8072066f761' -EmailRecipients $emailRecipient -ApplicationLogins $applicationLogin
            $siteTree = Get-BurpSuiteSiteTree

            # Assert
            $site = $siteTree.sites | Where-Object { $_.name -eq $name }

            $site | Should -Not -BeNullOrEmpty

            $site.scope.included_urls[0] | Should -Be "https://pester.dev/"
            $site.scope.excluded_urls[0] | Should -Be "https://pester.dev/login"

            $site.scan_configurations[0].id | Should -Be "a469d9d4-20ee-4d99-b727-c8072066f761"

            $site.email_recipients[0].email | Should -Be "foo@pester.dev"

            $site.application_logins[0].label | Should -Be "admin"
            $site.application_logins[0].username | Should -Be "admin"
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    Context 'Move-BurpSuiteSite' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
            (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteFolder -Confirm:$false
        }

        It 'should move site' {
            # Arrange
            $folderName = 'Pester - {0}' -f [Guid]::NewGuid()
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            New-BurpSuiteFolder -ParentId 0 -Name $folderName
            $folder = (Get-BurpSuiteSiteTree).folders | Where-Object { $_.Name -eq $folderName }

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            New-BurpSuiteSite -ParentId $folder.id -Name $siteName -Scope $scope -ScanConfigurationIds 'a469d9d4-20ee-4d99-b727-c8072066f761'

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            # Act
            Move-BurpSuiteSite -ParentId 0 -SiteId $site.Id

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -eq $siteName -and $_.parent_id -eq 0 }
            $site | Should -Not -BeNullOrEmpty
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
            (Get-BurpSuiteSiteTree).folders | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteFolder -Confirm:$false
        }
    }

    Context 'Update-BurpSuiteSiteEmailRecipient' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }

        It 'should update site email recipient' {
            # Arrange
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            $emailRecipient = [PSCustomObject]@{ Email = "foo@example.com" }
            New-BurpSuiteSite -ParentId 0 -Name $siteName -Scope $scope -ScanConfigurationIds 'a469d9d4-20ee-4d99-b727-c8072066f761' -EmailRecipients $emailRecipient

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            # Act
            Update-BurpSuiteSiteEmailRecipient -Id $site.email_recipients[0].id -Email "bar@example.com"

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }
            $site.email_recipients[0].email | Should -Be "bar@example.com"
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    Context 'Update-BurpSuiteSiteApplicationLogin' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }

        It 'should update site application login' {
            # Arrange
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            $applicationLogin = [PSCustomObject]@{ Label = "Admin"; Credential = (New-Object System.Management.Automation.PSCredential ("admin", $(ConvertTo-SecureString "ChangeMe" -AsPlainText -Force))) }
            New-BurpSuiteSite -ParentId 0 -Name $siteName -Scope $scope -ScanConfigurationIds 'a469d9d4-20ee-4d99-b727-c8072066f761' -ApplicationLogins $applicationLogin

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            $credentials = New-Object System.Management.Automation.PSCredential ("Admin2", $(ConvertTo-SecureString "changeme2" -AsPlainText -Force))

            # Act
            Update-BurpSuiteSiteApplicationLogin -Id $site.application_logins[0].id -Label "Admin2" -Credential $credentials

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }
            $site.application_logins[0].label | Should -Be "Admin2"
            $site.application_logins[0].username | Should -Be "Admin2"
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    Context 'Update-BurpSuiteSiteScanConfiguration' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }

        It 'should update site application login' {
            # Arrange
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            $scanConfiguration = Get-BurpSuiteScanConfiguration | Where-Object { $_.name -eq "Audit checks - all except JavaScript analysis" }

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            New-BurpSuiteSite -ParentId 0 -Name $siteName -Scope $scope -ScanConfigurationIds $scanConfiguration.id

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            # Act
            $newScanConfiguration = Get-BurpSuiteScanConfiguration | Where-Object { $_.name -eq "Audit checks - all except time-based detection methods" }
            Update-BurpSuiteSiteScanConfiguration -Id $site.id -ScanConfigurationIds $newScanConfiguration.id

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }
            $site.scan_configurations[0].id | Should -Be $newScanConfiguration.id
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    Context 'Update-BurpSuiteSiteScope' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }

        It 'should update site scope' {
            # Arrange
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            $scanConfiguration = Get-BurpSuiteScanConfiguration | Where-Object { $_.name -eq "Audit checks - all except JavaScript analysis" }

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            New-BurpSuiteSite -ParentId 0 -Name $siteName -Scope $scope -ScanConfigurationIds $scanConfiguration.id

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            # Act
            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester2.dev/") }
            Update-BurpSuiteSiteScope -SiteId $site.id -IncludedUrls "https://pester2.dev/" -ExcludedUrls "https://pester2.dev/foo"

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            $site.scope.included_urls[0] | Should -Be "https://pester2.dev/"
            $site.scope.excluded_urls[0] | Should -Be "https://pester2.dev/foo"
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    Context 'New-BurpSuiteSiteApplicationLogin' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }

        It 'should add site application login' {
            # Arrange
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            $scanConfiguration = Get-BurpSuiteScanConfiguration | Where-Object { $_.name -eq "Audit checks - all except JavaScript analysis" }

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            New-BurpSuiteSite -ParentId 0 -Name $siteName -Scope $scope -ScanConfigurationIds $scanConfiguration.id

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            $credentials = New-Object System.Management.Automation.PSCredential ("Admin", $(ConvertTo-SecureString "changeme" -AsPlainText -Force))

            # Act
            New-BurpSuiteSiteApplicationLogin -SiteId $site.id -Label "Admin" -Credential $credentials

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            $site.application_logins[0].label | Should -Be "Admin"
            $site.application_logins[0].username | Should -Be "Admin"
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    Context 'New-BurpSuiteSiteEmailRecipient' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }

        It 'should add site email recipient' {
            # Arrange
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            $scanConfiguration = Get-BurpSuiteScanConfiguration | Where-Object { $_.name -eq "Audit checks - all except JavaScript analysis" }

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            New-BurpSuiteSite -ParentId 0 -Name $siteName -Scope $scope -ScanConfigurationIds $scanConfiguration.id

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }


            # Act
            New-BurpSuiteSiteEmailRecipient -SiteId $site.id -EmailRecipient "foo@example.com"

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            $site.email_recipients[0].email | Should -Be "foo@example.com"
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    Context 'Remove-BurpSuiteSiteApplicationLogin' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }

        It 'should remove site application login' {
            # Arrange
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            $applicationLogin = [PSCustomObject]@{ Label = "Admin"; Username = "admin"; Password = "ChangeMe" }
            New-BurpSuiteSite -ParentId 0 -Name $siteName -Scope $scope -ScanConfigurationIds 'a469d9d4-20ee-4d99-b727-c8072066f761' -ApplicationLogins $applicationLogin

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            # Act
            Remove-BurpSuiteSiteApplicationLogin -Id $site.application_logins[0].id

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }
            $site.application_logins[0] | Should -BeNullOrEmpty
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    Context 'Remove-BurpSuiteSiteEmailRecipient' {
        BeforeEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }

        It 'should remove site email recipient' {
            # Arrange
            $siteName = 'Pester - {0}' -f [Guid]::NewGuid()

            $scope = [PSCustomObject]@{ IncludedUrls = @("https://pester.dev/") }
            $emailRecipient = [PSCustomObject]@{ Email = "foo@example.com" }
            New-BurpSuiteSite -ParentId 0 -Name $siteName -Scope $scope -ScanConfigurationIds 'a469d9d4-20ee-4d99-b727-c8072066f761' -EmailRecipients $emailRecipient

            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            # Act
            Remove-BurpSuiteSiteEmailRecipient -Id $site.email_recipients[0].id

            # Assert
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $siteName }

            $site.email_recipients[0] | Should -BeNullOrEmpty
        }

        AfterEach {
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }

    AfterAll {
        (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
    }
}
