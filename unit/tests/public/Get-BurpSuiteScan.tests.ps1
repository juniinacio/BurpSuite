InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteScan" {
        It "should get scan" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scans = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteScan -Id 1

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { scans:scan(id:'1') { * } }"
            }
        }

        It "should get scans" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scans = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteScan -Offset 1 -Limit 1 -SortColumn 'start' -SortOrder 'asc' -ScanStatus 'queued'

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { scans(limit:1,offset:1,scan_status:'queued',sort_column:'start',sort_order:'asc') { * } }"
            }
        }

        It "should get site scans" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scans = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteScan -Offset 1 -Limit 1 -SortColumn 'start' -SortOrder 'asc' -ScanStatus 'queued' -SiteId 1

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { scans(limit:1,offset:1,scan_status:'queued',site_id:'1',sort_column:'start',sort_order:'asc') { * } }"
            }
        }

        It "should add <FieldName> selection field" -TestCases @(
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
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scans = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            Mock -CommandName Write-Warning

            # act
            Get-BurpSuiteScan -Id 1 -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { scans:scan(id:'1') {* $FieldName *} }"
            }
        }

        It "should add <FieldName> sub selection field" -TestCases @(
            @{ FieldName = "schedule_item"; Query = "schedule_item { id }" }
            @{ FieldName = "agent"; Query = "agent { id name }" }
            @{ FieldName = "scan_metrics"; Query = "scan_metrics { crawl_request_count unique_location_count audit_request_count crawl_and_audit_progress_percentage }" }
            @{ FieldName = "scan_configurations"; Query = "scan_configurations { id }" }
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
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scans = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            Mock -CommandName Write-Warning

            # act
            Get-BurpSuiteScan -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { scans { *$query* } }"
            }
        }
    }
}
