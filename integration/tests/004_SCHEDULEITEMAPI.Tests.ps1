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

Describe 'Schedule Item API' -Tag 'CD' {
    BeforeAll {
        $BURPSUITE_APIKEY = $env:BURPSUITE_APIKEY
        $BURPSUITE_APIVERSION = $env:BURPSUITE_APIVERSION
        $BURPSUITE_URL = $env:BURPSUITE_URL

        Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL
    }

    Context 'New-BurpSuiteScheduleItem' {
        BeforeEach {
            $scanConfiguration = Get-BurpSuiteScanConfiguration | Where-Object { $_.name -eq "Crawl limit - 10 minutes" }
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
            $scope = [PSCustomObject]@{ IncludedUrls = @("https://github.com/juniinacio/BurpSuite/") }
            New-BurpSuiteSite -Name $name -Scope $scope -ScanConfigurationIds $scanConfiguration.id
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $name }
        }

        It 'should create run once time schedule item' {
            # Arrange

            # Act
            $scheduleItem = New-BurpSuiteScheduleItem -SiteId $site.id -ScanConfigurationIds $site.scan_configurations.id
            Get-BurpSuiteScan -Fields id, site_id, status | Where-Object { ($_.site_id -eq $site.Id) -and ($_.status -in @("running", "queued")) } | Stop-BurpSuiteScan -Confirm:$false


            # Assert
            $scheduleItem | Should -Not -BeNullOrEmpty
        }

        It 'should create recurrent time schedule item' {
            # Arrange
            $schedule = [PSCustomObject]@{ InitialRunTime = (Get-Date -Date ([DateTime]::UtcNow.AddSeconds(5)) -Format o); RRule = 'FREQ=DAILY;INTERVAL=1' }

            # Act
            $scheduleItem = New-BurpSuiteScheduleItem -SiteId $site.id -ScanConfigurationIds $site.scan_configurations.id -Schedule $schedule
            $scheduleItem = Get-BurpSuiteScheduleItem -Id $scheduleItem.id


            # Assert
            $scheduleItem | Should -Not -BeNullOrEmpty

            $scheduleItem.id | Should -Not -BeNullOrEmpty

            $scheduleItem.scheduled_run_time | Should -Not -BeNullOrEmpty

            $scheduleItem.schedule.initial_run_time | Should -Not -BeNullOrEmpty
            $scheduleItem.schedule.rrule | Should -Be 'FREQ=DAILY;INTERVAL=1'
        }

        AfterEach {
            Get-BurpSuiteScheduleItem | Remove-BurpSuiteScheduleItem -Confirm:$false
            Get-BurpSuiteScan -Fields id, site_id, status | Where-Object { ($_.site_id -eq $site.Id) -and ($_.status -in @("running", "queued")) } | Stop-BurpSuiteScan -Confirm:$false
            Get-BurpSuiteScan -Fields id, site_id | Where-Object { $_.site_id -eq $site.Id } | Remove-BurpSuiteScan -Confirm:$false
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }
}
