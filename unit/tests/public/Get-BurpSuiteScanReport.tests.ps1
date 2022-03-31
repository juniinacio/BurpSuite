InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteScanReport" {
        It "should get scan report" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_report = [PSCustomObject]@{
                            report_html = "<html></html>"
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteScanReport -ScanId 1 -TimezoneOffset 2 -ReportType 'detailed' -Severities 'info', 'low', 'medium', 'high'

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -eq "query { scan_report(report_type:detailed,scan_id:1,severities:[info,low,medium,high],timezone_offset:2) { report_html } }"
            }
        }

        It "should get scan report including false positives" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_report = [PSCustomObject]@{
                            report_html = "<html></html>"
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteScanReport -ScanId 1 -TimezoneOffset 2 -ReportType 'detailed' -IncludeFalsePositives -Severities 'info', 'low', 'medium', 'high'

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -eq "query { scan_report(include_false_positives:true,report_type:detailed,scan_id:1,severities:[info,low,medium,high],timezone_offset:2) { report_html } }"
            }
        }

        It "should get scan report excluding false positives" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_report = [PSCustomObject]@{
                            report_html = "<html></html>"
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteScanReport -ScanId 1 -TimezoneOffset 2 -ReportType 'detailed' -IncludeFalsePositives:$false -Severities 'info', 'low', 'medium', 'high'

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -eq "query { scan_report(include_false_positives:false,report_type:detailed,scan_id:1,severities:[info,low,medium,high],timezone_offset:2) { report_html } }"
            }
        }

        It "should store scan report on physical disk" {
            # arrange
            $content = "<html><bod><p>Hello World!</p></body></html>"

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_report = [PSCustomObject]@{
                            report_html = $content
                        }
                    }
                }
            } -Verifiable

            Mock -CommandName Out-File

            $outFile = Join-Path -Path $TestDrive -ChildPath 'scan_report.html'

            # act
            Get-BurpSuiteScanReport -ScanId 1 -TimezoneOffset 2 -ReportType 'detailed' -IncludeFalsePositives -Severities 'info', 'low', 'medium', 'high' -OutFile $outFile

            # assert
            Should -InvokeVerifiable
            Should -Invoke Out-File -ParameterFilter {
                $FilePath -eq $outFile `
                    -and $InputObject -eq $content
            }
        }
    }
}
