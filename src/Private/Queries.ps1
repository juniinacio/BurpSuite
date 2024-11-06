function _buildField {
    param([string]$name, [string]$objectType)

    $query = [Query]::New($name)

    $fields = @()

    switch ($objectType) {
        Id { $fields = 'id' }
        Agent { $fields = 'id', 'name' }
        AgentError { $fields = 'code', 'error' }
        ApplicationLogin { $fields = (_buildField -name 'login_credentials' -objectType 'LoginCredential'), (_buildField -name 'recorded_logins' -objectType 'RecordedLogin') }
        LoginCredential { $fields = 'id', 'label', 'username' }
        RecordedLogin { $fields = 'id', 'label' }
        AuditItem { $fields = 'id', 'host', 'path', 'error_types', (_buildField -name 'issue_counts' -objectType 'IssueCounts'), 'number_of_requests', 'number_of_errors', 'number_of_insertion_points', (_buildField -name 'issue_types' -objectType 'IssueType') }
        CountsByConfidence { $fields = 'total', 'firm', 'tentative', 'certain' }
        DataSegment { $fields = 'data_html' }
        DescriptiveEvidence { $fields = 'title', 'description_html' }
        EmailRecipient { $fields = 'id', 'email' }
        Folder { $fields = 'id', 'name', 'parent_id' }
        HighlightSegment { $fields = 'highlight_html' }
        HttpInteraction { $fields = 'title', 'description_html', 'request', 'response' }
        Issue { $fields = 'confidence', 'serial_number', 'severity', 'novelty' }
        IssueCounts { $fields = 'total', (_buildField -name 'high' -objectType 'CountsByConfidence'), (_buildField -name 'medium' -objectType 'CountsByConfidence'), (_buildField -name 'low' -objectType 'CountsByConfidence'), (_buildField -name 'info' -objectType 'CountsByConfidence') }
        IssueType { $fields = 'type_index', 'confidence', 'severity', 'number_of_children', 'first_child_serial_number', 'novelty' }
        JiraTicket { $fields = 'id', 'external_key', 'issue_type', 'summary', 'project', 'status', 'priority' }
        Request { $fields = 'request_index', 'request_count', 'request_segments' }
        Response { $fields = 'response_index', 'response_count', 'response_segments' }
        Scan { $fields = 'id' }
        ScanConfiguration { $fields = 'id' }
        ScanCountsByStatus { $fields = 'scheduled', 'queued', 'running', 'succeeded', 'cancelled', 'failed' }
        ScanDelta { $fields = 'new_issue_count', 'repeated_issue_count', 'regressed_issue_count', 'resolved_issue_count' }
        ScanProgressMetrics { $fields = 'crawl_request_count', 'unique_location_count', 'audit_request_count', 'crawl_and_audit_progress_percentage' }
        Schedule { $fields = 'initial_run_time', 'rrule' }
        ScheduleItem { $fields = 'id' }
        # Scope { $fields = 'included_urls', 'excluded_urls' } # Deprecated
        { ($_ -eq "Scope") -or ($_ -eq "ScopeV2") } { $fields = 'start_urls', 'in_scope_url_prefixes', 'out_of_scope_url_prefixes', 'protocol_options' }
        Site { $fields = 'id', 'name', 'parent_id', (_buildField -name 'scope_v2' -objectType 'ScopeV2'), (_buildField -name 'scan_configurations' -objectType 'ScanConfiguration'), (_buildField -name 'application_logins' -objectType 'ApplicationLogin'), 'ephemeral', (_buildField -name 'email_recipients' -objectType 'EmailRecipient') }
        SiteTree { $fields = (_buildField -name 'folders' -objectType 'Folder'), (_buildField -name 'sites' -objectType 'Site') }
        SnipSegment { $fields = 'snip_length' }
        Ticket { $fields = (_buildField -name 'jira_ticket' -objectType 'JiraTicket'), 'link_url', 'link_id' }
        User { $fields = 'username' }
        QueryType { $fields = 'name' }
        MutationType { $fields = 'name' }
        FalsePositive { $fields = 'successful' }
    }

    $query.AddFields($fields)

    return $query
}


function _buildQuery {
    param([string]$name, [string]$alias = "", [string]$objectType, [string[]]$fields, [hashtable]$arguments)

    $query = [Query]::New($name)

    if (-not ([string]::IsNullOrEmpty($alias))) { $query.SetAlias($alias) }

    switch ($objectType) {
        Agent {
            $fields | Where-Object { $_ -ne 'error' } | ForEach-Object { $query.AddField($_) }
            if ($fields -contains 'error') { $query.AddField((_buildField -name 'error' -objectType 'AgentError')) }
        }

        Scan {
            $subFields = 'schedule_item', 'agent', 'scan_metrics', 'scan_configurations', 'scan_delta', 'issue_types', 'issue_counts', 'audit_items', 'audit_item', 'scope_v2', 'site_application_logins', 'schedule_item_application_logins', 'issues'
            $fields | Where-Object { $_ -notin $subFields } | ForEach-Object { $query.AddField($_) }

            if ($fields -contains 'schedule_item') { $query.AddField((_buildField -name 'schedule_item' -objectType 'ScheduleItem')) }
            if ($fields -contains 'agent') { $query.AddField((_buildField -name 'agent' -objectType 'Agent')) }
            if ($fields -contains 'scan_metrics') { $query.AddField((_buildField -name 'scan_metrics' -objectType 'ScanProgressMetrics')) }
            if ($fields -contains 'generated_by') { $query.AddField((_buildField -name 'generated_by' -objectType 'GeneratedBy')) }
            if ($fields -contains 'scan_configurations') { $query.AddField((_buildField -name 'scan_configurations' -objectType 'ScanConfiguration')) }
            if ($fields -contains 'scan_delta') { $query.AddField((_buildField -name 'scan_delta' -objectType 'ScanDelta')) }
            if ($fields -contains 'issue_types') { $query.AddField((_buildField -name 'issue_types' -objectType 'IssueType')) }
            if ($fields -contains 'issue_counts') { $query.AddField((_buildField -name 'issue_counts' -objectType 'IssueCounts')) }
            if ($fields -contains 'audit_item') { $query.AddField((_buildField -name 'audit_item' -objectType 'AuditItem')) }
            if (($fields -contains 'scope') -or ($fields -contains 'scope_v2')) { $query.AddField((_buildField -name 'scope_v2' -objectType 'ScopeV2')) }
            if ($fields -contains 'audit_items') { $query.AddField((_buildField -name 'audit_items' -objectType 'AuditItem')) }
            if ($fields -contains 'site_application_logins') { $query.AddField((_buildField -name 'site_application_logins' -objectType 'ApplicationLogin')) }
            if ($fields -contains 'schedule_item_application_logins') { $query.AddField((_buildField -name 'schedule_item_application_logins' -objectType 'ApplicationLogin')) }
            if ($fields -contains 'issues') { $query.AddField((_buildField -name 'issues' -objectType 'Issue')) }
        }

        Issue {
            $fields | Where-Object { $_ -ne 'tickets' } | ForEach-Object { $query.AddField($_) }
            if ($fields -contains 'tickets') { $query.AddField((_buildField -name 'tickets' -objectType 'Ticket')) }
        }

        ScanConfiguration {
            $fields | Where-Object { $_ -ne 'last_modified_by' } | ForEach-Object { $query.AddField($_) }
            if ($fields -contains 'last_modified_by') { $query.AddField((_buildField -name 'last_modified_by' -objectType 'User')) }
        }

        ScanReport {
            $query.AddField('report_html')
        }

        ScheduleItem {
            $subFields = 'site', 'schedule', 'scan_configurations'
            $fields | Where-Object { $_ -notin $subFields } | ForEach-Object { $query.AddField($_) }
            if ($fields -contains 'site') { $query.AddField((_buildField -name 'site' -objectType 'Site')) }
            if ($fields -contains 'schedule') { $query.AddField((_buildField -name 'schedule' -objectType 'Schedule')) }
            if ($fields -contains 'scan_configurations') { $query.AddField((_buildField -name 'scan_configurations' -objectType 'ScanConfiguration')) }
        }

        SiteTree {
            if ($fields -contains 'folders') { $query.AddField((_buildField -name 'folders' -objectType 'Folder')) }
            if ($fields -contains 'sites') { $query.AddField((_buildField -name 'sites' -objectType 'Site')) }
        }

        UnauthorizedAgent {
            $fields | ForEach-Object { $query.AddField($_) }
        }

        Schema {
            $query.AddField((_buildField -name 'queryType' -objectType 'QueryType'))
            $query.AddField((_buildField -name 'mutationType' -objectType 'MutationType'))
        }

        default {}
    }

    if ($null -ne $arguments) { foreach ($k in ($arguments.Keys | Sort-Object)) { $query.AddArgument($k, $arguments[$k]) } }

    return ('query {{ {0} }}' -f $query)
}
