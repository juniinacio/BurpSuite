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
                $GraphRequest.OperationName -eq "GetReport" `
                    -and $GraphRequest.Query -eq 'query GetReport($scan_id:ID!,$timezone_offset:Int,$report_type:ScanReportType,$severities:[Severity]) { scan_report(scan_id:$scan_id,timezone_offset:$timezone_offset,report_type:$report_type,severities:$severities) { report_html } }' `
                    -and $GraphRequest.Variables.scan_id -eq 1 `
                    -and $GraphRequest.Variables.timezone_offset -eq 2 `
                    -and $GraphRequest.Variables.report_type -eq 'detailed' `
                    -and ($GraphRequest.Variables.severities -join ',') -eq (@('info', 'low', 'medium', 'high') -join ',')
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
                $GraphRequest.OperationName -eq "GetReport" `
                    -and $GraphRequest.Query -eq 'query GetReport($scan_id:ID!,$timezone_offset:Int,$report_type:ScanReportType,$include_false_positives:Boolean,$severities:[Severity]) { scan_report(scan_id:$scan_id,timezone_offset:$timezone_offset,report_type:$report_type,include_false_positives:$include_false_positives,severities:$severities) { report_html } }' `
                    -and $GraphRequest.Variables.scan_id -eq 1 `
                    -and $GraphRequest.Variables.timezone_offset -eq 2 `
                    -and $GraphRequest.Variables.report_type -eq 'detailed' `
                    -and $GraphRequest.Variables.include_false_positives -eq "true" `
                    -and ($GraphRequest.Variables.severities -join ',') -eq (@('info', 'low', 'medium', 'high') -join ',')
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
                $GraphRequest.OperationName -eq "GetReport" `
                    -and $GraphRequest.Query -eq 'query GetReport($scan_id:ID!,$timezone_offset:Int,$report_type:ScanReportType,$include_false_positives:Boolean,$severities:[Severity]) { scan_report(scan_id:$scan_id,timezone_offset:$timezone_offset,report_type:$report_type,include_false_positives:$include_false_positives,severities:$severities) { report_html } }' `
                    -and $GraphRequest.Variables.scan_id -eq 1 `
                    -and $GraphRequest.Variables.timezone_offset -eq 2 `
                    -and $GraphRequest.Variables.report_type -eq 'detailed' `
                    -and $GraphRequest.Variables.include_false_positives -eq "false" `
                    -and ($GraphRequest.Variables.severities -join ',') -eq (@('info', 'low', 'medium', 'high') -join ',')
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
