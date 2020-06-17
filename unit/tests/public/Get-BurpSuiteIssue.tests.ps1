InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteIssue" {
        It "should get issue" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        serial_number = 314276827364273645
                    }
                }
            }

            # act
            Get-BurpSuiteIssue -ScanId 1 -SerialNumber 314276827364273645

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "getIssue" `
                    -and $GraphRequest.Query -like "query getIssue(`$scanId:ID!,`$serialNumber:ID!) { issue(scan_id:`$scanId,serial_number:`$serialNumber) { * } }" `
                    -and $GraphRequest.Variables.scanId -eq 1 `
                    -and $GraphRequest.Variables.serialNumber -eq 314276827364273645
            }
        }

        It "should add <FieldName> selection field" -TestCases @(
            @{ FieldName = "confidence" }
            @{ FieldName = "display_confidence" }
            @{ FieldName = "serial_number" }
            @{ FieldName = "severity" }
            @{ FieldName = "description_html" }
            @{ FieldName = "remediation_html" }
            @{ FieldName = "type_index" }
            @{ FieldName = "path" }
            @{ FieldName = "origin" }
            @{ FieldName = "novelty" }
            @{ FieldName = "evidence" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        serial_number = 314276827364273645
                    }
                }
            }

            # act
            Get-BurpSuiteIssue -ScanId 1 -SerialNumber 314276827364273645 -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.Query -like "query getIssue(`$scanId:ID!,`$serialNumber:ID!) { issue(scan_id:`$scanId,serial_number:`$serialNumber) {* $FieldName *} }"
            }
        }

        It "should add <FieldName> sub selection field" -TestCases @(
            @{ FieldName = "tickets"; Query = "tickets { jira_ticket { id external_key issue_type summary project status priority } link_url link_id }" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        serial_number = 314276827364273645
                    }
                }
            }

            # act
            Get-BurpSuiteIssue -ScanId 1 -SerialNumber 314276827364273645 -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.Query -like "query getIssue(`$scanId:ID!,`$serialNumber:ID!) { issue(scan_id:`$scanId,serial_number:`$serialNumber) { *$FieldName* } }"
            }
        }
    }
}
