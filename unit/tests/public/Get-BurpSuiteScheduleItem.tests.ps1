InModuleScope $env:BHProjectName {
    Context "Specific" {
        Describe "Get-BurpSuiteScheduleItem" {
            It "should get schedule item" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScheduleItem -ID 1

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.OperationName -eq "GetScheduleItem" `
                        -and $GraphRequest.Query -like 'query GetScheduleItem($id:ID!) { schedule_item(id:$id) { * } }' `
                        -and $GraphRequest.Variables.id -eq 1
                }
            }

            It "should add <FieldName> query field" -TestCases @(
                @{ FieldName = "id" }
                @{ FieldName = "has_run_more_than_once" }
                @{ FieldName = "scheduled_run_time" }
            ) {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScheduleItem -ID 1 -Fields $FieldName

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.Query -like "query GetScheduleItem(`$id:ID!) { schedule_item(id:`$id) {* $FieldName *} }"
                }
            }

            It "should add <FieldName> sub query field" -TestCases @(
                @{ FieldName = "site"; Query = "site { id name parent_id scope { included_urls excluded_urls } scan_configurations { id name } application_logins { id label username } ephemeral email_recipients { id email } }" }
                @{ FieldName = "schedule"; Query = "schedule { initial_run_time rrule }" }
                @{ FieldName = "scan_configurations"; Query = "scan_configurations { id name }" }
            ) {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScheduleItem -ID 1 -Fields $FieldName

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.Query -like "query GetScheduleItem(`$id:ID!) { schedule_item(id:`$id) { *$Query*} }"
                }
            }

            It "should get schedule items" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteScheduleItem -SortBy 'site' -SortOrder 'asc'

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.OperationName -eq "GetScheduleItems" `
                        -and $GraphRequest.Query -like 'query GetScheduleItems($sort_by:string,$sort_order:string) { schedule_items(sort_by:$sort_by,sort_order:$sort_order) { * } }' `
                        -and $GraphRequest.Variables.sort_by -eq 'site' `
                        -and $GraphRequest.Variables.sort_order -eq 'asc'
                }
            }
        }
    }
}