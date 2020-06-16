InModuleScope $env:BHProjectName {
    Context "Specific" {
        Describe "Get-BurpSuiteScanReport" {
            It "should get scan report" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScanReport -ID 1

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.OperationName -eq "GetReport" `
                        -and $GraphRequest.Query -eq 'query GetReport($scan_id:ID!,$include_false_positives:Boolean) { scan_report(scan_id:$scan_id,include_false_positives:$include_false_positives) { report_html } }' `
                        -and $GraphRequest.Variables.scan_id -eq 1 `
                        -and $GraphRequest.Variables.include_false_positives -eq "false"
                }
            }

            It "should get scan report including false positives" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScanReport -ID 1 -IncludeFalsePositives

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.OperationName -eq "GetReport" `
                        -and $GraphRequest.Query -eq 'query GetReport($scan_id:ID!,$include_false_positives:Boolean) { scan_report(scan_id:$scan_id,include_false_positives:$include_false_positives) { report_html } }' `
                        -and $GraphRequest.Variables.scan_id -eq 1 `
                        -and $GraphRequest.Variables.include_false_positives -eq "true"
                }
            }
        }
    }
}
