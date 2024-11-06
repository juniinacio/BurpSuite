InModuleScope BurpSuite {
    Describe "Queries" {
        Context "_buildField" {

            It "should build <ObjectName> object" -TestCases @(
                @{ObjectName = "Agent"; FieldName = "agent"; Query = "agent { id name }" }
                @{ObjectName = "ApplicationLogin"; FieldName = "application_login"; Query = "application_login { login_credentials { id label username } recorded_logins { id label } }" }
                @{ObjectName = "LoginCredential"; FieldName = "login_credential"; Query = "login_credential { id label username }" }
                @{ObjectName = "AgentError"; FieldName = "error"; Query = "error { code error }" }
                @{ObjectName = "AuditItem"; FieldName = "audit_item"; Query = "audit_item { id host path error_types issue_counts { total high { total firm tentative certain } medium { total firm tentative certain } low { total firm tentative certain } info { total firm tentative certain } } number_of_requests number_of_errors number_of_insertion_points issue_types { type_index confidence severity number_of_children first_child_serial_number novelty } }" }
                @{ObjectName = "CountsByConfidence"; FieldName = "counts_by_confidence"; Query = "counts_by_confidence { total firm tentative certain }" }
                @{ObjectName = "DataSegment"; FieldName = "data_segment"; Query = "data_segment { data_html }" }
                @{ObjectName = "DescriptiveEvidence"; FieldName = "descriptive_evidence"; Query = "descriptive_evidence { title description_html }" }
                @{ObjectName = "EmailRecipient"; FieldName = "email_recipient"; Query = "email_recipient { id email }" }
                @{ObjectName = "Folder"; FieldName = "folder"; Query = "folder { id name parent_id }" }
                @{ObjectName = "HighlightSegment"; FieldName = "highlight_segment"; Query = "highlight_segment { highlight_html }" }
                @{ObjectName = "HttpInteraction"; FieldName = "http_interaction"; Query = "http_interaction { title description_html request response }" }
                @{ObjectName = "Issue"; FieldName = "issue"; Query = "issue { confidence serial_number severity novelty }" }
                @{ObjectName = "IssueCounts"; FieldName = "issue_counts"; Query = "issue_counts { total high { total firm tentative certain } medium { total firm tentative certain } low { total firm tentative certain } info { total firm tentative certain } }" }
                @{ObjectName = "IssueType"; FieldName = "issue_type"; Query = "issue_type { type_index confidence severity number_of_children first_child_serial_number novelty }" }
                @{ObjectName = "JiraTicket"; FieldName = "jira_ticket"; Query = "jira_ticket { id external_key issue_type summary project status priority }" }
                @{ObjectName = "Request"; FieldName = "request"; Query = "request { request_index request_count request_segments }" }
                @{ObjectName = "Response"; FieldName = "response"; Query = "response { response_index response_count response_segments }" }
                @{ObjectName = "ScanConfiguration"; FieldName = "scan_configuration"; Query = "scan_configuration { id }" }
                @{ObjectName = "ScanCountsByStatus"; FieldName = "scan_counts_by_status"; Query = "scan_counts_by_status { scheduled queued running succeeded cancelled failed }" }
                @{ObjectName = "ScanDelta"; FieldName = "scan_delta"; Query = "scan_delta { new_issue_count repeated_issue_count regressed_issue_count resolved_issue_count }" }
                @{ObjectName = "ScanProgressMetrics"; FieldName = "scan_progress_metrics"; Query = "scan_progress_metrics { crawl_request_count unique_location_count audit_request_count crawl_and_audit_progress_percentage }" }
                @{ObjectName = "Schedule"; FieldName = "schedule"; Query = "schedule { initial_run_time rrule }" }
                @{ObjectName = "ScheduleItem"; FieldName = "schedule_item"; Query = "schedule_item { id }" }
                @{ObjectName = "ScopeV2"; FieldName = "scope_v2"; Query = "scope_v2 { start_urls in_scope_url_prefixes out_of_scope_url_prefixes protocol_options }" }
                @{ObjectName = "Site"; FieldName = "site"; Query = "site { id name parent_id scope_v2 { start_urls in_scope_url_prefixes out_of_scope_url_prefixes protocol_options } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } }" }
                @{ObjectName = "SiteTree"; FieldName = "site_tree"; Query = "site_tree { folders { id name parent_id } sites { id name parent_id scope_v2 { start_urls in_scope_url_prefixes out_of_scope_url_prefixes protocol_options } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } } }" }
                @{ObjectName = "SnipSegment"; FieldName = "snip_segment"; Query = "snip_segment { snip_length }" }
                @{ObjectName = "Ticket"; FieldName = "ticket"; Query = "ticket { jira_ticket { id external_key issue_type summary project status priority } link_url link_id }" }
                @{ObjectName = "User"; FieldName = "user"; Query = "user { username }" }
            ) {
                # arrange

                # act
                $assert = _buildField -name $FieldName -objectType $ObjectName

                # assert
                "$assert" | Should -BeExactly $Query
            }
        }
    }
}
