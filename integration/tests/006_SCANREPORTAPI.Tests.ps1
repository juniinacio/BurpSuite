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

Describe 'Scan Report API' -Tag 'CD' {
    BeforeAll {
        $BURPSUITE_APIKEY = $env:BURPSUITE_APIKEY
        $BURPSUITE_APIVERSION = $env:BURPSUITE_APIVERSION
        $BURPSUITE_URL = $env:BURPSUITE_URL

        Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL
    }

    Context 'Get-BurpSuiteScanReport' {
        BeforeAll {
            $scanConfiguration = Get-BurpSuiteScanConfiguration | Where-Object { $_.name -eq "Crawl limit - 10 minutes" }
            $name = 'Pester - {0}' -f [Guid]::NewGuid()
            $scope = [PSCustomObject]@{ IncludedUrls = @("https://github.com/juniinacio/BurpSuite/") }
            New-BurpSuiteSite -Name $name -Scope $scope -ScanConfigurationIds $scanConfiguration.id
            $site = (Get-BurpSuiteSiteTree).sites | Where-Object { $_.Name -eq $name }

            New-BurpSuiteScheduleItem -SiteId $site.id -ScanConfigurationIds $site.scan_configurations.id
            Start-Sleep -Seconds 5

            $maxWaitInSeconds = 300
            $totalWaitTimeInSeconds = 0
            do {
                $scan = Get-BurpSuiteScan -Fields id, site_id, status | Where-Object { $_.site_id -eq $site.id }
                Start-Sleep -Seconds 5
                $totalWaitTimeInSeconds += 5
            } while ($scan.status -in @("running", "queued") -or ($totalWaitTimeInSeconds -gt $maxWaitInSeconds))
        }

        It 'should get scan report' {
            # Arrange
            $outFile = Join-Path -Path $TestDrive -ChildPath 'scan_report.html'

            $scan = Get-BurpSuiteScan -Fields id, site_id, status | Where-Object { $_.site_id -eq $site.id }

            # Act
            $assert = $scan | Get-BurpSuiteScanReport


            # Assert
            $assert.report_html | Should -BeLike '<html>*'
        }

        # It 'should download scan report' {
        #     # Arrange
        #     $outFile = Join-Path -Path $TestDrive -ChildPath 'scan_report.html'

        #     $scan = Get-BurpSuiteScan -Fields id, site_id, status | Where-Object { $_.site_id -eq $site.id }

        #     # Act
        #     $scan | Get-BurpSuiteScanReport -OutFile $outFile


        #     # Assert
        #     $outFile | Should -FileContentMatch '^<html>'
        # }

        AfterEach {
            Get-BurpSuiteScan -Fields id, site_id, status | Where-Object { ($_.site_id -eq $site.Id) -and ($_.status -in @("running", "queued")) } | Stop-BurpSuiteScan -Confirm:$false
            Get-BurpSuiteScan -Fields id, site_id | Where-Object { $_.site_id -eq $site.Id } | Remove-BurpSuiteScan -Confirm:$false
            (Get-BurpSuiteSiteTree).sites | Where-Object { $_.name -like 'Pester - *' } | Remove-BurpSuiteSite -Confirm:$false
        }
    }
}
