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
                        -and $GraphRequest.Query -like 'query GetScan($id:ID!) { scan(id:$id) { * } }' `
                        -and $GraphRequest.Variables.id -eq 1
                }
            }

            It "should get scans" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScan -Offset 1 -Limit 1 -SortColumn 'start' -SortOrder 'asc' -ScanStatus 'queued'

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.OperationName -eq "GetScans" `
                        -and $GraphRequest.Query -like 'query GetScans($offset:int,$limit:int,$sort_column:string,$sort_order:string,$scan_status:string) { scans(offset:$offset,limit:$limit,sort_column:$sort_column,sort_order:$sort_order,scan_status:$scan_status) { * } }' `
                        -and $GraphRequest.Variables.offset -eq 1 `
                        -and $GraphRequest.Variables.limit -eq 1 `
                        -and $GraphRequest.Variables.sort_column -eq 'start' `
                        -and $GraphRequest.Variables.sort_order -eq 'asc' `
                        -and $GraphRequest.Variables.scan_status -eq 'queued'
                }
            }

            It "should add <FieldName> query field" -TestCases @(
                @{ FieldName = "id" }
                @{ FieldName = "site_id" }
                @{ FieldName = "site_name" }
                @{ FieldName = "start_time" }
                @{ FieldName = "end_time" }
                @{ FieldName = "duration_in_seconds" }
                @{ FieldName = "status" }
                @{ FieldName = "scan_failure_message" }
                @{ FieldName = "generated_by" }
                @{ FieldName = "scanner_version" }
                @{ FieldName = "jira_ticket_count" }
            ) {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScan -ID 1 -Fields $FieldName

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.Query -like "query GetScan(`$id:ID!) { scan(id:`$id) {* $FieldName *} }"
                }
            }

            It "should add <FieldName> sub query field" -TestCases @(
                @{ FieldName = "schedule_item"; Query = "schedule_item { id site }" }
                @{ FieldName = "agent"; Query = "agent { id name }" }
                @{ FieldName = "scan_metrics"; Query = "scan_metrics { crawl_request_count unique_location_count audit_request_count crawl_and_audit_progress_percentage }" }
                @{ FieldName = "scan_configurations"; Query = "scan_configurations { id name }" }
                @{ FieldName = "scan_delta"; Query = "scan_delta { new_issue_count repeated_issue_count regressed_issue_count resolved_issue_count }" }
                @{ FieldName = "issue_types"; Query = "issue_types { type_index confidence severity number_of_children first_child_serial_number novelty }" }
                @{ FieldName = "issue_counts"; Query = "issue_counts { total high { total firm tentative certain } medium { total firm tentative certain } low { total firm tentative certain } info { total firm tentative certain } }" }
                @{ FieldName = "audit_items"; Query = "audit_items { id host path error_types issue_counts { total high { total firm tentative certain } medium { total firm tentative certain } low { total firm tentative certain } info { total firm tentative certain } } number_of_requests number_of_errors number_of_insertion_points issue_types { type_index confidence severity number_of_children first_child_serial_number novelty } }" }
                @{ FieldName = "audit_item"; Query = "audit_item { id host path error_types issue_counts { total high { total firm tentative certain } medium { total firm tentative certain } low { total firm tentative certain } info { total firm tentative certain } } number_of_requests number_of_errors number_of_insertion_points issue_types { type_index confidence severity number_of_children first_child_serial_number novelty } }" }
                @{ FieldName = "scope"; Query = "scope { included_urls excluded_urls }" }
                @{ FieldName = "site_application_logins"; Query = "site_application_logins { id label username }" }
                @{ FieldName = "schedule_item_application_logins"; Query = "schedule_item_application_logins { id label username }" }
                @{ FieldName = "issues"; Query = "issues { confidence serial_number severity novelty }" }
            ) {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScan -Offset 1 -Limit 1 -SortColumn 'start' -SortOrder 'asc' -ScanStatus 'queued' -Fields $FieldName

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.Query -like "query GetScans(`$offset:int,`$limit:int,`$sort_column:string,`$sort_order:string,`$scan_status:string) { scans(offset:`$offset,limit:`$limit,sort_column:`$sort_column,sort_order:`$sort_order,scan_status:`$scan_status) { *$query* } }"
                }
            }
        }
    }
}
