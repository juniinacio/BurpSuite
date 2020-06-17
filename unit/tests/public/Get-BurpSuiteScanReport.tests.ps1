InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteScanReport" {
        It "should get scan report" {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteScanReport -ID 1 -TimezoneOffset 2 -ReportType 'detailed' -Severities 'info', 'low', 'medium', 'high'

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
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteScanReport -ID 1 -TimezoneOffset 2 -ReportType 'detailed' -IncludeFalsePositives:$false -Severities 'info', 'low', 'medium', 'high'

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
    }
}
