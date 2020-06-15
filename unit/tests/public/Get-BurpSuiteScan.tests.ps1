InModuleScope $env:BHProjectName {
    Context "Specific" {
        Describe "Get-BurpSuiteScan" {
            It "should get scan" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScan -ID 1

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.OperationName -eq "GetScan" `
                        -and $GraphRequest.Query -eq 'query GetScan($id:ID!) { scan(id:$id) { id status agent { id name } issue_types { confidence severity novelty } site_application_logins { label username } audit_items { id number_of_requests issue_counts { total } } scan_configurations { id name } } }' `
                        -and $GraphRequest.Variables.id -eq 1
                }
            }

            # It "should set issue fields" {
            #     # arrange
            #     $fields = 'confidence', 'display_confidence', 'serial_number', 'severity', 'description_html', 'remediation_html', 'type_index', 'path',
            #     'origin', 'novelty', 'evidence'

            #     Mock -CommandName _callAPI

            #     # act
            #     Get-BurpSuiteScan -ID 1 -SerialNumber 314276827364273645 -Fields $fields

            #     # assert
            #     Should -Invoke _callAPI -ParameterFilter {
            #         $GraphRequest.Query -eq "query getIssue(`$scanId:ID!,`$serialNumber:ID!) { issue(scan_id:`$scanId,serial_number:`$serialNumber) { $($fields -join ' ') } }"
            #     }
            # }

            # It "should set tickets fields" {
            #     # arrange
            #     $fields = 'link_url', 'link_id'

            #     Mock -CommandName _callAPI

            #     # act
            #     Get-BurpSuiteScan -ID 1 -SerialNumber 314276827364273645 -TicketFields $fields

            #     # assert
            #     Should -Invoke _callAPI -ParameterFilter {
            #         $GraphRequest.Query -eq "query getIssue(`$scanId:ID!,`$serialNumber:ID!) { issue(scan_id:`$scanId,serial_number:`$serialNumber) { confidence serial_number severity novelty tickets { $($fields -join ' ') } } }"
            #     }
            # }

            # It "should set jira_ticket fields" {
            #     # arrange
            #     $fields = 'id', 'external_key', 'issue_type', 'summary', 'project', 'status', 'priority'

            #     Mock -CommandName _callAPI

            #     # act
            #     Get-BurpSuiteScan -ID 1 -SerialNumber 314276827364273645 -JiraTicketFields $fields

            #     # assert
            #     Should -Invoke _callAPI -ParameterFilter {
            #         $GraphRequest.Query -eq "query getIssue(`$scanId:ID!,`$serialNumber:ID!) { issue(scan_id:`$scanId,serial_number:`$serialNumber) { confidence serial_number severity novelty tickets { jira_ticket { $($fields -join ' ') } } } }"
            #     }
            # }
        }
    }
}
