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

Describe 'Scan API' -Tag 'CD' {
    BeforeAll {
        $BURPSUITE_APIKEY = $env:BURPSUITE_APIKEY
        $BURPSUITE_APIVERSION = $env:BURPSUITE_APIVERSION
        $BURPSUITE_URL = $env:BURPSUITE_URL

        Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL
    }

    Context 'Stop-BurpSuiteScan' {
        BeforeEach {
            $scanConfiguration = Get-BurpSuiteScanConfiguration | Where-Object { $_.name -eq "Crawl limit - 10 minutes" }
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
            $scope = [PSCustomObject]@{ StartUrls = @("https://github.com/juniinacio/BurpSuite/") }
            New-BurpSuiteSite -Name $name -Scope $scope -ScanConfigurationIds $scanConfiguration.id
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $name }
        }

        It 'should cancel running/queued scan' {
            # Arrange
            $scheduleItem = New-BurpSuiteScheduleItem -SiteId $site.id -ScanConfigurationIds $site.scan_configurations.id
            Start-Sleep -Seconds 3

            $scan = Get-BurpSuiteScan -Fields id, site_id | Where-Object { $_.site_id -eq $site.id }

            # Act
            $scan | Stop-BurpSuiteScan -Confirm:$false
            Start-Sleep -Seconds 3


            # Assert
            $scan = Get-BurpSuiteScan -Fields id, site_id, status | Where-Object { $_.site_id -eq $site.id }

            $scan.status | Should -Not -Be 'running'
            $scan.status | Should -Not -Be 'queued'
        }

        AfterEach {
            Get-BurpSuiteScan -Fields id, site_id, status | Where-Object { ($_.site_id -eq $site.Id) -and ($_.status -in @("running", "queued")) } | Stop-BurpSuiteScan -Confirm:$false
            Get-BurpSuiteScan -Fields id, site_id | Where-Object { $_.site_id -eq $site.Id } | Remove-BurpSuiteScan -Confirm:$false
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }
}
