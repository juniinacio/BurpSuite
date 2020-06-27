function _buildQueryField {
    param([string]$name, [string]$objectType)

    $query = [Query]::New($name)

    switch ($objectType) {
        Id {
            $query.AddField('id') | Out-Null
        }

        Agent {
            $query.AddField('id') | Out-Null
            $query.AddField('name') | Out-Null
        }

        AgentError {
            $query.AddField('code') | Out-Null
            $query.AddField('error') | Out-Null
        }

        ApplicationLogin {
            $query.AddField('id') | Out-Null
            $query.AddField('label') | Out-Null
            $query.AddField('username') | Out-Null
        }

        AuditItem {
            $query.AddField('id') | Out-Null
            $query.AddField('host') | Out-Null
            $query.AddField('path') | Out-Null
            $query.AddField('error_types') | Out-Null
            $query.AddField((_buildQueryField -name 'issue_counts' -objectType 'IssueCounts')) | Out-Null
            $query.AddField('number_of_requests') | Out-Null
            $query.AddField('number_of_errors') | Out-Null
            $query.AddField('number_of_insertion_points') | Out-Null
            $query.AddField((_buildQueryField -name 'issue_types' -objectType 'IssueType')) | Out-Null
        }

        CountsByConfidence {
            $query.AddField('total') | Out-Null
            $query.AddField('firm') | Out-Null
            $query.AddField('tentative') | Out-Null
            $query.AddField('certain') | Out-Null
        }

        DataSegment {
            $query.AddField('data_html') | Out-Null
        }

        DescriptiveEvidence {
            $query.AddField('title') | Out-Null
            $query.AddField('description_html') | Out-Null
        }

        EmailRecipient {
            $query.AddField('id') | Out-Null
            $query.AddField('email') | Out-Null
        }

        Folder {
            $query.AddField('id') | Out-Null
            $query.AddField('name') | Out-Null
            $query.AddField('parent_id') | Out-Null
        }

        HighlightSegment {
            $query.AddField('highlight_html') | Out-Null
        }

        HttpInteraction {
            $query.AddField('title') | Out-Null
            $query.AddField('description_html') | Out-Null
            $query.AddField('request') | Out-Null
            $query.AddField('response') | Out-Null
        }

        Issue {
            $query.AddField('confidence') | Out-Null
            $query.AddField('serial_number') | Out-Null
            $query.AddField('severity') | Out-Null
            $query.AddField('novelty') | Out-Null
        }

        IssueCounts {
            $query.AddField('total') | Out-Null
            $query.AddField((_buildQueryField -name 'high' -objectType 'CountsByConfidence')) | Out-Null
            $query.AddField((_buildQueryField -name 'medium' -objectType 'CountsByConfidence')) | Out-Null
            $query.AddField((_buildQueryField -name 'low' -objectType 'CountsByConfidence')) | Out-Null
            $query.AddField((_buildQueryField -name 'info' -objectType 'CountsByConfidence')) | Out-Null
        }

        IssueType {
            $query.AddField('type_index') | Out-Null
            $query.AddField('confidence') | Out-Null
            $query.AddField('severity') | Out-Null
            $query.AddField('number_of_children') | Out-Null
            $query.AddField('first_child_serial_number') | Out-Null
            $query.AddField('novelty') | Out-Null
        }

        JiraTicket {
            $query.AddField('id') | Out-Null
            $query.AddField('external_key') | Out-Null
            $query.AddField('issue_type') | Out-Null
            $query.AddField('summary') | Out-Null
            $query.AddField('project') | Out-Null
            $query.AddField('status') | Out-Null
            $query.AddField('priority') | Out-Null
        }

        Request {
            $query.AddField('request_index') | Out-Null
            $query.AddField('request_count') | Out-Null
            $query.AddField('request_segments') | Out-Null
        }

        Response {
            $query.AddField('response_index') | Out-Null
            $query.AddField('response_count') | Out-Null
            $query.AddField('response_segments') | Out-Null
        }

        Scan {
            $query.AddField('id') | Out-Null
        }

        ScanConfiguration {
            $query.AddField('id') | Out-Null
            # $query.AddField('name') | Out-Null
        }

        ScanCountsByStatus {
            $query.AddField('scheduled') | Out-Null
            $query.AddField('queued') | Out-Null
            $query.AddField('running') | Out-Null
            $query.AddField('succeeded') | Out-Null
            $query.AddField('cancelled') | Out-Null
            $query.AddField('failed') | Out-Null
        }

        ScanDelta {
            $query.AddField('new_issue_count') | Out-Null
            $query.AddField('repeated_issue_count') | Out-Null
            $query.AddField('regressed_issue_count') | Out-Null
            $query.AddField('resolved_issue_count') | Out-Null
        }

        ScanProgressMetrics {
            $query.AddField('crawl_request_count') | Out-Null
            $query.AddField('unique_location_count') | Out-Null
            $query.AddField('audit_request_count') | Out-Null
            $query.AddField('crawl_and_audit_progress_percentage') | Out-Null
        }

        Schedule {
            $query.AddField('initial_run_time') | Out-Null
            $query.AddField('rrule') | Out-Null
        }

        ScheduleItem {
            $query.AddField('id') | Out-Null
        }

        Scope {
            $query.AddField('included_urls') | Out-Null
            $query.AddField('excluded_urls') | Out-Null
        }

        Site {
            $query.AddField('id') | Out-Null
            $query.AddField('name') | Out-Null
            $query.AddField('parent_id') | Out-Null
            $query.AddField((_buildQueryField -name 'scope' -objectType 'Scope')) | Out-Null
            $query.AddField((_buildQueryField -name 'scan_configurations' -objectType 'ScanConfiguration')) | Out-Null
            $query.AddField((_buildQueryField -name 'application_logins' -objectType 'ApplicationLogin')) | Out-Null
            $query.AddField('ephemeral') | Out-Null
            $query.AddField((_buildQueryField -name 'email_recipients' -objectType 'EmailRecipient')) | Out-Null
        }

        SiteTree {
            $query.AddField((_buildQueryField -name 'folders' -objectType 'Folder')) | Out-Null
            $query.AddField((_buildQueryField -name 'sites' -objectType 'Site')) | Out-Null
        }

        SnipSegment {
            $query.AddField('snip_length') | Out-Null
        }

        Ticket {
            $query.AddField((_buildQueryField -name 'jira_ticket' -objectType 'JiraTicket')) | Out-Null
            $query.AddField('link_url') | Out-Null
            $query.AddField('link_id') | Out-Null
        }

        User {
            $query.AddField('username') | Out-Null
        }

        QueryType {
            $query.AddField('name') | Out-Null
        }

        MutationType {
            $query.AddField('name') | Out-Null
        }

        FalsePositive {
            $query.AddField('successful') | Out-Null
        }
    }

    return $query
}


function _buildQuery {
    param([string]$name, [string]$alias = "", [string]$objectType, [string[]]$fields, [hashtable]$arguments)

    $query = [Query]::New($name)
    if (-not ([string]::IsNullOrEmpty($alias))) {
        $query.SetAlias($alias)
    }

    switch ($objectType) {
        Agent {
            $fields | Where-Object { $_ -ne 'error' } | ForEach-Object { $query.AddField($_) }
            if ($fields -contains 'error') { $query.AddField((_buildQueryField -name 'error' -objectType 'AgentError')) }
        }

        Scan {
            $subFields = 'schedule_item', 'agent', 'scan_metrics', 'scan_configurations', 'scan_delta', 'issue_types', 'issue_counts', 'audit_items', 'audit_item', 'scope', 'site_application_logins', 'schedule_item_application_logins', 'issues'
            $fields | Where-Object { $_ -notin $subFields } | ForEach-Object { $query.AddField($_) }

            if ($fields -contains 'schedule_item') { $query.AddField((_buildQueryField -name 'schedule_item' -objectType 'ScheduleItem')) }
            if ($fields -contains 'agent') { $query.AddField((_buildQueryField -name 'agent' -objectType 'Agent')) }
            if ($fields -contains 'scan_metrics') { $query.AddField((_buildQueryField -name 'scan_metrics' -objectType 'ScanProgressMetrics')) }
            if ($fields -contains 'generated_by') { $query.AddField((_buildQueryField -name 'generated_by' -objectType 'GeneratedBy')) }
            if ($fields -contains 'scan_configurations') { $query.AddField((_buildQueryField -name 'scan_configurations' -objectType 'ScanConfiguration')) }
            if ($fields -contains 'scan_delta') { $query.AddField((_buildQueryField -name 'scan_delta' -objectType 'ScanDelta')) }
            if ($fields -contains 'issue_types') { $query.AddField((_buildQueryField -name 'issue_types' -objectType 'IssueType')) }
            if ($fields -contains 'issue_counts') { $query.AddField((_buildQueryField -name 'issue_counts' -objectType 'IssueCounts')) }
            if ($fields -contains 'audit_item') { $query.AddField((_buildQueryField -name 'audit_item' -objectType 'AuditItem')) }
            if ($fields -contains 'scope') { $query.AddField((_buildQueryField -name 'scope' -objectType 'Scope')) }
            if ($fields -contains 'audit_items') { $query.AddField((_buildQueryField -name 'audit_items' -objectType 'AuditItem')) }
            if ($fields -contains 'site_application_logins') { $query.AddField((_buildQueryField -name 'site_application_logins' -objectType 'ApplicationLogin')) }
            if ($fields -contains 'schedule_item_application_logins') { $query.AddField((_buildQueryField -name 'schedule_item_application_logins' -objectType 'ApplicationLogin')) }
            if ($fields -contains 'issues') { $query.AddField((_buildQueryField -name 'issues' -objectType 'Issue')) }
        }

        Issue {
            $fields | Where-Object { $_ -ne 'tickets' } | ForEach-Object { $query.AddField($_) }
            if ($fields -contains 'tickets') { $query.AddField((_buildQueryField -name 'tickets' -objectType 'Ticket')) }
        }

        ScanConfiguration {
            $fields | Where-Object { $_ -ne 'last_modified_by' } | ForEach-Object { $query.AddField($_) | Out-Null }
            if ($fields -contains 'last_modified_by') { $query.AddField((_buildQueryField -name 'last_modified_by' -objectType 'User')) }
        }

        ScanReport {
            $query.AddField('report_html')
        }

        ScheduleItem {
            $subFields = 'site', 'schedule', 'scan_configurations'
            $fields | Where-Object { $_ -notin $subFields } | ForEach-Object { $query.AddField($_) }
            if ($fields -contains 'site') { $query.AddField((_buildQueryField -name 'site' -objectType 'Site')) }
            if ($fields -contains 'schedule') { $query.AddField((_buildQueryField -name 'schedule' -objectType 'Schedule')) }
            if ($fields -contains 'scan_configurations') { $query.AddField((_buildQueryField -name 'scan_configurations' -objectType 'ScanConfiguration')) }
        }

        SiteTree {
            if ($fields -contains 'folders') { $query.AddField((_buildQueryField -name 'folders' -objectType 'Folder')) }
            if ($fields -contains 'sites') { $query.AddField((_buildQueryField -name 'sites' -objectType 'Site')) }
        }

        UnauthorizedAgent {
            $fields | ForEach-Object { $query.AddField($_) }
        }

        Schema {
            $query.AddField((_buildQueryField -name 'queryType' -objectType 'QueryType'))
            $query.AddField((_buildQueryField -name 'mutationType' -objectType 'MutationType'))
        }

        default {}
    }

    if ($null -ne $arguments) {
        foreach ($k in ($arguments.Keys | Sort-Object)) { $query.AddArgument($k, $arguments[$k]) }
    }

    return ('query {{ {0} }}' -f $query)
}
