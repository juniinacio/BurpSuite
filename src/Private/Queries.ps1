function _buildIntrospectionQuery {
    param()

    $operationName = 'IntrospectionQuery'

    $queryTypeField = [Query]::New('queryType')
    $queryTypeField.AddField("name") | Out-Null

    $mutationTypeField = [Query]::New('mutationType')
    $mutationTypeField.AddField("name") | Out-Null

    $schemaField = [Query]::New('__schema')
    $schemaField.AddField($queryTypeField) | Out-Null
    $schemaField.AddField($mutationTypeField) | Out-Null

    $introspectionQuery = [Query]::New($operationName)
    $introspectionQuery.AddField($schemaField) | Out-Null

    $query = 'query {0}' -f $introspectionQuery

    $Request = [Request]::new($query, $operationName)

    return $Request
}

function _agentQuery {
    param ([string]$queryName, [string[]] $selectFields, [string]$queryType)

    if ($null -eq $selectFields) { $selectFields = 'id', 'name', 'state', 'enabled' }

    $subSelectFields = 'error'

    if ($queryType -eq 'List') { $queryName = 'GetAgents' } else { $queryName = 'GetAgent' }

    $agentField = [Query]::New('agent')
    if ($queryType -eq 'List') {
        $agentField = [Query]::New('agents')
    }

    $selectFields | Where-Object { $_ -notin $subSelectFields } | ForEach-Object { $agentField.AddField($_) | Out-Null }

    if ($selectFields -contains 'error') { $agentField.AddField((_buildObjectQuery -name 'error' -objectType 'AgentError')) | Out-Null }

    if ($queryType -eq 'Specific') { $agentField.AddArgument('id', '$id') | Out-Null }

    $agentQuery = [Query]::New($queryName)

    $agentQuery.AddField($agentField) | Out-Null

    if ($queryType -eq 'Specific') { $agentQuery.AddArgument('$id', 'ID!') | Out-Null }

    $query = 'query {0}' -f $agentQuery

    return $query
}

function _buildIssueQuery {
    param ([hashtable] $parameters)

    if (-not ($parameters.ContainsKey('Fields'))) {
        $parameters['Fields'] = 'confidence', 'serial_number', 'severity', 'novelty'
    }

    $subFields = 'tickets'

    $operationName = 'getIssue'

    $issueField = [Query]::New('issue')

    $parameters['Fields'] | Where-Object { $_ -notin $subFields } | ForEach-Object { $issueField.AddField($_) | Out-Null }

    if ($parameters['Fields'] -contains 'tickets') { $issueField.AddField((_buildObjectQuery -name 'tickets' -objectType 'Ticket')) | Out-Null }

    $issueField.AddArgument('scan_id', '$scanId') | Out-Null
    $issueField.AddArgument('serial_number', '$serialNumber') | Out-Null

    $issueQuery = [Query]::New($operationName)
    $issueQuery.AddField($issueField) | Out-Null

    $issueQuery.AddArgument('$scanId', 'ID!') | Out-Null
    $issueQuery.AddArgument('$serialNumber', 'ID!') | Out-Null

    $query = 'query {0}' -f $issueQuery

    $Request = [Request]::new($query, $operationName)
    $Request.Variables.scanId = $parameters.ScanId
    $Request.Variables.serialNumber = $parameters.SerialNumber

    return $Request
}

function _buildScanConfigurationQuery {
    param ([hashtable] $parameters)

    if (-not ($parameters.ContainsKey('Fields'))) { $parameters['Fields'] = 'id', 'name' }

    $subFields = 'last_modified_by'

    $operationName = 'GetScanConfigurations'

    $scanConfigurationsField = [Query]::New('scan_configurations')
    $parameters['Fields'] | Where-Object { $_ -notin $subFields } | ForEach-Object { $scanConfigurationsField.AddField($_) | Out-Null }

    if ($parameters['Fields'] -contains 'last_modified_by') { $scanConfigurationsField.AddField((_buildObjectQuery -name 'last_modified_by' -objectType 'User')) | Out-Null }

    $scanConfigurationQuery = [Query]::New($operationName)
    $scanConfigurationQuery.AddField($scanConfigurationsField) | Out-Null

    $query = 'query {0}' -f $scanConfigurationQuery.ToString()

    $Request = [Request]::new($query, $operationName)

    return $Request
}

function _buildUnauthorizedAgentQuery {
    param ([hashtable] $parameters)

    if (-not ($parameters.ContainsKey('Fields'))) { $parameters['Fields'] = 'ip' }

    $operationName = 'GetUnauthorizedAgents'

    $unauthorizedAgentsField = [Query]::New('unauthorized_agents')
    $parameters['Fields'] | ForEach-Object { $unauthorizedAgentsField.AddField($_) | Out-Null }

    $unauthorizedAgentsQuery = [Query]::New($operationName)
    $unauthorizedAgentsQuery.AddField($unauthorizedAgentsField) | Out-Null

    $query = 'query {0}' -f $unauthorizedAgentsQuery

    $Request = [Request]::new($query, $operationName)

    return $Request
}

function _buildScanQuery {
    param ([hashtable] $parameters, [string]$queryType)

    if (-not ($parameters.ContainsKey('Fields'))) {
        # $parameters['Fields'] = 'id', 'status', 'agent', 'issue_types', 'site_application_logins',
        # 'audit_items', 'scan_configurations'
        $parameters['Fields'] = 'id', 'status', 'issue_counts'
    }

    $subFields = 'schedule_item', 'agent', 'scan_metrics', 'scan_configurations', 'scan_delta', 'issue_types', 'issue_counts', 'audit_items', 'audit_item', 'scope', 'site_application_logins', 'schedule_item_application_logins', 'issues'

    if ($queryType -eq 'List') { $operationName = 'GetScans' } else { $operationName = 'GetScan' }

    if ($queryType -eq 'List') {
        $scanField = [Query]::New("scans")
        if ($parameters.ContainsKey('Offset')) { $scanField.AddArgument('offset', '$offset') | Out-Null }
        if ($parameters.ContainsKey('Limit')) { $scanField.AddArgument('limit', '$limit') | Out-Null }
        if ($parameters.ContainsKey('SortColumn')) { $scanField.AddArgument('sort_column', '$sort_column') | Out-Null }
        if ($parameters.ContainsKey('SortOrder')) { $scanField.AddArgument('sort_order', '$sort_order') | Out-Null }
        if ($parameters.ContainsKey('ScanStatus')) { $scanField.AddArgument('scan_status', '$scan_status') | Out-Null }
    } else {
        $scanField = [Query]::New("scan")
        $scanField.AddArgument('id', '$id') | Out-Null
    }

    $parameters['Fields'] | Where-Object { $_ -notin $subFields } | ForEach-Object { $scanField.AddField($_) | Out-Null }

    if ($parameters['Fields'] -contains 'schedule_item') { $scanField.AddField((_buildObjectQuery -name 'schedule_item' -objectType 'ScheduleItem')) | Out-Null }
    if ($parameters['Fields'] -contains 'agent') { $scanField.AddField((_buildObjectQuery -name 'agent' -objectType 'Agent')) | Out-Null }
    if ($parameters['Fields'] -contains 'scan_metrics') { $scanField.AddField((_buildObjectQuery -name 'scan_metrics' -objectType 'ScanProgressMetrics')) | Out-Null }
    if ($parameters['Fields'] -contains 'generated_by') { $scanField.AddField((_buildObjectQuery -name 'generated_by' -objectType 'GeneratedBy')) | Out-Null }
    if ($parameters['Fields'] -contains 'scan_configurations') { $scanField.AddField((_buildObjectQuery -name 'scan_configurations' -objectType 'ScanConfiguration')) | Out-Null }
    if ($parameters['Fields'] -contains 'scan_delta') { $scanField.AddField((_buildObjectQuery -name 'scan_delta' -objectType 'ScanDelta')) | Out-Null }
    if ($parameters['Fields'] -contains 'issue_types') { $scanField.AddField((_buildObjectQuery -name 'issue_types' -objectType 'IssueType')) | Out-Null }
    if ($parameters['Fields'] -contains 'issue_counts') { $scanField.AddField((_buildObjectQuery -name 'issue_counts' -objectType 'IssueCounts')) | Out-Null }
    if ($parameters['Fields'] -contains 'audit_items') { $scanField.AddField((_buildObjectQuery -name 'audit_items' -objectType 'AuditItem')) | Out-Null }
    if ($parameters['Fields'] -contains 'audit_item') { $scanField.AddField((_buildObjectQuery -name 'audit_item' -objectType 'AuditItem')) | Out-Null }
    if ($parameters['Fields'] -contains 'scope') { $scanField.AddField((_buildObjectQuery -name 'scope' -objectType 'Scope')) | Out-Null }
    if ($parameters['Fields'] -contains 'site_application_logins') { $scanField.AddField((_buildObjectQuery -name 'site_application_logins' -objectType 'ApplicationLogin')) | Out-Null }
    if ($parameters['Fields'] -contains 'schedule_item_application_logins') { $scanField.AddField((_buildObjectQuery -name 'schedule_item_application_logins' -objectType 'ApplicationLogin')) | Out-Null }
    if ($parameters['Fields'] -contains 'issues') { $scanField.AddField((_buildObjectQuery -name 'issues' -objectType 'Issue')) | Out-Null }

    $scanQuery = [Query]::New($operationName)
    if ($queryType -eq 'List') {
        if ($parameters.ContainsKey('Offset')) { $scanQuery.AddArgument('$offset', 'Int') | Out-Null }
        if ($parameters.ContainsKey('Limit')) { $scanQuery.AddArgument('$limit', 'Int') | Out-Null }
        if ($parameters.ContainsKey('SortColumn')) { $scanQuery.AddArgument('$sort_column', 'ScansSortColumn') | Out-Null }
        if ($parameters.ContainsKey('SortOrder')) { $scanQuery.AddArgument('$sort_order', 'SortOrder') | Out-Null }
        if ($parameters.ContainsKey('ScanStatus')) { $scanQuery.AddArgument('$scan_status', '[ScanStatus]') | Out-Null }
    } else {
        $scanQuery.AddArgument('$id', 'ID!') | Out-Null
    }
    $scanQuery.AddField($scanField) | Out-Null

    $query = 'query {0}' -f $scanQuery

    $Request = [Request]::new($query, $operationName)

    if ($queryType -eq 'List') {
        if ($parameters.ContainsKey('Offset')) { $Request.Variables.offset = $parameters.Offset }
        if ($parameters.ContainsKey('Limit')) { $Request.Variables.limit = $parameters.Limit }
        if ($parameters.ContainsKey('SortColumn')) { $Request.Variables.sort_column = $parameters.SortColumn }
        if ($parameters.ContainsKey('SortOrder')) { $Request.Variables.sort_order = $parameters.SortOrder }
        if ($parameters.ContainsKey('ScanStatus')) { $Request.Variables.scan_status = @($parameters.ScanStatus) }
    } else { $Request.Variables.id = $parameters.Id }

    return $Request
}

function _buildScanReportQuery {
    param ([hashtable] $parameters)

    $operationName = 'GetReport'

    $scanReportField = [Query]::New('scan_report')

    $scanReportField.AddArgument('scan_id', '$scan_id') | Out-Null
    if ($parameters.ContainsKey('TimezoneOffset')) { $scanReportField.AddArgument('timezone_offset', '$timezone_offset') | Out-Null }
    if ($parameters.ContainsKey('ReportType')) { $scanReportField.AddArgument('report_type', '$report_type') | Out-Null }
    if ($parameters.ContainsKey('IncludeFalsePositives')) { $scanReportField.AddArgument('include_false_positives', '$include_false_positives') | Out-Null }
    if ($parameters.ContainsKey('Severities')) { $scanReportField.AddArgument('severities', '$severities') | Out-Null }

    $scanReportField.AddField('report_html') | Out-Null

    $scanReportQuery = [Query]::New($operationName)

    $scanReportQuery.AddArgument('$scan_id', 'ID!') | Out-Null
    if ($parameters.ContainsKey('TimezoneOffset')) { $scanReportQuery.AddArgument('$timezone_offset', 'Int') | Out-Null }
    if ($parameters.ContainsKey('ReportType')) { $scanReportQuery.AddArgument('$report_type', 'ScanReportType') | Out-Null }
    if ($parameters.ContainsKey('IncludeFalsePositives')) { $scanReportQuery.AddArgument('$include_false_positives', 'Boolean') | Out-Null }
    if ($parameters.ContainsKey('Severities')) { $scanReportQuery.AddArgument('$severities', '[Severity]') | Out-Null }

    $scanReportQuery.AddField($scanReportField) | Out-Null

    $query = 'query {0}' -f $scanReportQuery

    $Request = [Request]::new($query, $operationName)

    $Request.Variables.scan_id = $parameters.ScanId

    if ($parameters.ContainsKey('TimezoneOffset')) { $Request.Variables.timezone_offset = $parameters.TimezoneOffset }
    if ($parameters.ContainsKey('ReportType')) { $Request.Variables.report_type = $parameters.ReportType }
    if ($parameters.ContainsKey('IncludeFalsePositives')) {
        $Request.Variables.include_false_positives = "false"
        if ($parameters.IncludeFalsePositives -eq $true) { $Request.Variables.include_false_positives = "true" }
    }
    if ($parameters.ContainsKey('Severities')) { $Request.Variables.severities = @($parameters.Severities) }

    return $Request
}

function _buildScheduleItemQuery {
    param ([hashtable] $parameters, [string]$queryType)

    if (-not ($parameters.ContainsKey('Fields'))) {
        $parameters['Fields'] = 'id', 'schedule', 'scheduled_run_time'
    }

    $subFields = 'site', 'schedule', 'scan_configurations'

    $operationName = 'GetScheduleItem'
    if ($queryType -eq 'List') {
        $operationName = 'GetScheduleItems'
    }

    if ($queryType -eq 'List') {
        $scheduleItemField = [Query]::New("schedule_items")
        if ($parameters.ContainsKey('SortBy')) { $scheduleItemField.AddArgument('sort_by', '$sort_by') | Out-Null }
        if ($parameters.ContainsKey('SortOrder')) { $scheduleItemField.AddArgument('sort_order', '$sort_order') | Out-Null }
    } else {
        $scheduleItemField = [Query]::New('schedule_item')
        $scheduleItemField.AddArgument('id', '$id') | Out-Null
    }

    $parameters['Fields'] | Where-Object { $_ -notin $subFields } | ForEach-Object { $scheduleItemField.AddField($_) | Out-Null }

    if ($parameters['Fields'] -contains 'site') { $scheduleItemField.AddField((_buildObjectQuery -name 'site' -objectType 'Site')) | Out-Null }
    if ($parameters['Fields'] -contains 'schedule') { $scheduleItemField.AddField((_buildObjectQuery -name 'schedule' -objectType 'Schedule')) | Out-Null }
    if ($parameters['Fields'] -contains 'scan_configurations') { $scheduleItemField.AddField((_buildObjectQuery -name 'scan_configurations' -objectType 'ScanConfiguration')) | Out-Null }

    $scheduleItemQuery = [Query]::New($operationName)

    if ($queryType -eq 'List') {
        if ($parameters.ContainsKey('SortBy')) { $scheduleItemQuery.AddArgument('$sort_by', 'String') | Out-Null }
        if ($parameters.ContainsKey('SortOrder')) { $scheduleItemQuery.AddArgument('$sort_order', 'String') | Out-Null }
    } else { $scheduleItemQuery.AddArgument('$id', 'ID!') | Out-Null }

    $scheduleItemQuery.AddField($scheduleItemField) | Out-Null

    $query = 'query {0}' -f $scheduleItemQuery

    $Request = [Request]::new($query, $operationName)

    if ($queryType -eq 'List') {
        if ($parameters.ContainsKey('SortBy')) { $Request.Variables.sort_by = $parameters.SortBy }
        if ($parameters.ContainsKey('SortOrder')) { $Request.Variables.sort_order = $parameters.SortOrder }
    } else { $Request.Variables.id = $parameters.Id }

    return $Request
}

function _buildSuiteSiteTreeQuery {
    param ([hashtable] $parameters)

    if (-not ($parameters.ContainsKey('Fields'))) {
        $parameters['Fields'] = 'folders', 'sites'
    }

    $operationName = 'GetSiteTree'

    $siteTreeField = [Query]::New('site_tree')

    if ($parameters['Fields'] -contains 'folders') { $siteTreeField.AddField((_buildObjectQuery -name 'folders' -objectType 'Folder')) | Out-Null }

    if ($parameters['Fields'] -contains 'sites') {
        $scanConfigurationsField = [Query]::New('scan_configurations')
        $scanConfigurationsField.AddField('id') | Out-Null

        $sitesField = [Query]::New('sites')
        $sitesField.AddField('id') | Out-Null
        $sitesField.AddField('name') | Out-Null
        $sitesField.AddField('parent_id') | Out-Null
        $sitesField.AddField((_buildObjectQuery -name 'scope' -objectType 'Scope')) | Out-Null
        $sitesField.AddField($scanConfigurationsField) | Out-Null
        $sitesField.AddField((_buildObjectQuery -name 'application_logins' -objectType 'ApplicationLogin')) | Out-Null
        $sitesField.AddField('ephemeral') | Out-Null
        $sitesField.AddField((_buildObjectQuery -name 'email_recipients' -objectType 'EmailRecipient')) | Out-Null
        $siteTreeField.AddField($sitesField) | Out-Null
    }

    $siteTreeQuery = [Query]::New($operationName)

    $siteTreeQuery.AddField($siteTreeField) | Out-Null

    $query = 'query {0}' -f $siteTreeQuery

    $Request = [Request]::new($query, $operationName)

    return $Request
}

function _buildObjectQuery {
    param([string]$name, [string]$objectType)

    $query = [Query]::New($name)

    switch ($objectType) {
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
            $query.AddField((_buildObjectQuery -name 'issue_counts' -objectType 'IssueCounts')) | Out-Null
            $query.AddField('number_of_requests') | Out-Null
            $query.AddField('number_of_errors') | Out-Null
            $query.AddField('number_of_insertion_points') | Out-Null
            $query.AddField((_buildObjectQuery -name 'issue_types' -objectType 'IssueType')) | Out-Null
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
            $query.AddField((_buildObjectQuery -name 'high' -objectType 'CountsByConfidence')) | Out-Null
            $query.AddField((_buildObjectQuery -name 'medium' -objectType 'CountsByConfidence')) | Out-Null
            $query.AddField((_buildObjectQuery -name 'low' -objectType 'CountsByConfidence')) | Out-Null
            $query.AddField((_buildObjectQuery -name 'info' -objectType 'CountsByConfidence')) | Out-Null
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

        ScanConfiguration {
            $query.AddField('id') | Out-Null
            $query.AddField('name') | Out-Null
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
            $query.AddField((_buildObjectQuery -name 'scope' -objectType 'Scope')) | Out-Null
            $query.AddField((_buildObjectQuery -name 'scan_configurations' -objectType 'ScanConfiguration')) | Out-Null
            $query.AddField((_buildObjectQuery -name 'application_logins' -objectType 'ApplicationLogin')) | Out-Null
            $query.AddField('ephemeral') | Out-Null
            $query.AddField((_buildObjectQuery -name 'email_recipients' -objectType 'EmailRecipient')) | Out-Null
        }

        SiteTree {
            $query.AddField((_buildObjectQuery -name 'folders' -objectType 'Folder')) | Out-Null
            $query.AddField((_buildObjectQuery -name 'sites' -objectType 'Site')) | Out-Null
        }

        SnipSegment {
            $query.AddField('snip_length') | Out-Null
        }

        Ticket {
            $query.AddField((_buildObjectQuery -name 'jira_ticket' -objectType 'JiraTicket')) | Out-Null
            $query.AddField('link_url') | Out-Null
            $query.AddField('link_id') | Out-Null
        }

        User {
            $query.AddField('username') | Out-Null
        }
    }

    return $query
}
