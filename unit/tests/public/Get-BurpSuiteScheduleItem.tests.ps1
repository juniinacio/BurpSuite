InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteScheduleItem" {
        It "should get schedule item" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_items = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteScheduleItem -ID 1

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { schedule_items:schedule_item(id:'1') { * } }"
            }
        }

        It "should add <FieldName> selection field" -TestCases @(
            @{ FieldName = "id" }
            @{ FieldName = "has_run_more_than_once" }
            @{ FieldName = "scheduled_run_time" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_item = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteScheduleItem -ID 1 -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { schedule_items:schedule_item(id:'1') {* $FieldName *} }"
            }
        }

        It "should add <FieldName> sub selection field" -TestCases @(
            @{ FieldName = "site"; Query = "site { id name parent_id scope { included_urls excluded_urls } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } }" }
            @{ FieldName = "schedule"; Query = "schedule { initial_run_time rrule }" }
            @{ FieldName = "scan_configurations"; Query = "scan_configurations { id }" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_item = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteScheduleItem -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { schedule_items { *$Query*} }"
            }
        }

        It "should get schedule items" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_items = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteScheduleItem -SortBy 'site' -SortOrder 'asc'

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { schedule_items(sort_by:'site',sort_order:'asc') { * } }"
            }
        }
    }
}
