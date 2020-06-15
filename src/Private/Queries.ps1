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

    $graphRequest = [GraphRequest]::new($query, $operationName)

    return $graphRequest
}

function _buildAgentQuery {
    param ([hashtable] $parameters)

    if (-not ($parameters.ContainsKey('Fields'))) { $parameters['Fields'] = 'id', 'name', 'state', 'enabled' }

    $operationName = 'GetAgents'
    if ($parameters.ContainsKey('ID')) { $operationName = 'GetAgent' }

    $agentField = [Query]::New('agents')
    if ($parameters.ContainsKey('ID')) { $agentField = [Query]::New('agent') }

    $parameters['Fields'] | ForEach-Object { $agentField.AddField($_) | Out-Null }

    if ($parameters.ContainsKey('ID')) { $agentField.AddArgument('id', '$id') | Out-Null }

    if ($parameters.ContainsKey('ErrorFields')) {
        $errorField = [Query]::New('error')

        $parameters['ErrorFields'] | ForEach-Object { $errorField.AddField($_) | Out-Null }

        $agentField.AddField($errorField) | Out-Null
    }

    $agentQuery = [Query]::New($operationName)
    $agentQuery.AddField($agentField) | Out-Null

    if ($parameters.ContainsKey('ID')) { $agentQuery.AddArgument('$id', 'ID!') | Out-Null }

    $query = 'query {0}' -f $agentQuery

    $graphRequest = [GraphRequest]::new($query, $operationName)

    if ($parameters.ContainsKey('ID')) { $graphRequest.Variables.id = $parameters.ID }

    return $graphRequest
}

function _buildIssueQuery {
    param ([hashtable] $parameters)

    if (-not ($parameters.ContainsKey('Fields'))) { $parameters['Fields'] = 'confidence', 'serial_number', 'severity', 'novelty' }

    $operationName = 'getIssue'

    $issueField = [Query]::New('issue')
    $parameters['Fields'] | ForEach-Object { $issueField.AddField($_) | Out-Null }

    $issueField.AddArgument('scan_id', '$scanId') | Out-Null
    $issueField.AddArgument('serial_number', '$serialNumber') | Out-Null

    if ($parameters.ContainsKey('TicketFields') -or $parameters.ContainsKey('JiraTicketFields')) {
        $ticketField = [Query]::New('tickets')

        if ($parameters.ContainsKey('TicketFields')) {
            $parameters['TicketFields'] | ForEach-Object { $ticketField.AddField($_) | Out-Null }
        }

        if ($parameters.ContainsKey('JiraTicketFields')) {
            $jiraTicketField = [Query]::New('jira_ticket')
            $parameters['JiraTicketFields'] | ForEach-Object { $jiraTicketField.AddField($_) | Out-Null }
            $ticketField.AddField($jiraTicketField) | Out-Null
        }

        $issueField.AddField($ticketField) | Out-Null
    }

    $issueQuery = [Query]::New($operationName)
    $issueQuery.AddField($issueField) | Out-Null

    $issueQuery.AddArgument('$scanId', 'ID!') | Out-Null
    $issueQuery.AddArgument('$serialNumber', 'ID!') | Out-Null

    $query = 'query {0}' -f $issueQuery

    $graphRequest = [GraphRequest]::new($query, $operationName)
    $graphRequest.Variables.scanId = $parameters.ID
    $graphRequest.Variables.serialNumber = $parameters.SerialNumber

    return $graphRequest
}

function _buildScanConfigurationQuery {
    param ([hashtable] $parameters)

    if (-not ($parameters.ContainsKey('Fields'))) { $parameters['Fields'] = 'id', 'name' }

    $operationName = 'GetScanConfigurations'

    $scanConfigurationsField = [Query]::New('scan_configurations')
    $parameters['Fields'] | ForEach-Object { $scanConfigurationsField.AddField($_) | Out-Null }

    $scanConfigurationQuery = [Query]::New($operationName)
    $scanConfigurationQuery.AddField($scanConfigurationsField) | Out-Null

    $query = 'query {0}' -f $scanConfigurationQuery.ToString()

    $graphRequest = [GraphRequest]::new($query, $operationName)

    return $graphRequest
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

    $graphRequest = [GraphRequest]::new($query, $operationName)

    return $graphRequest
}

function _buildScanQuery {
    param ([hashtable] $parameters, [string]$queryType)

    if (-not ($parameters.ContainsKey('Fields'))) { $parameters['Fields'] = 'id', 'status' }
    if (-not ($parameters.ContainsKey('AgentFields'))) { $parameters['AgentFields'] = 'id', 'name' }
    if (-not ($parameters.ContainsKey('IssueTypesFields'))) { $parameters['IssueTypesFields'] = 'confidence', 'severity', 'novelty' }
    if (-not ($parameters.ContainsKey('SiteApplicationLoginsFields'))) { $parameters['SiteApplicationLoginsFields'] = 'label', 'username' }
    if (-not ($parameters.ContainsKey('AuditItemsField'))) { $parameters['AuditItemsField'] = 'id', 'number_of_requests' }
    if (-not ($parameters.ContainsKey('IssueCountsFields'))) { $parameters['IssueCountsFields'] = 'total' }
    if (-not ($parameters.ContainsKey('ScanConfigurationsFields'))) { $parameters['ScanConfigurationsFields'] = 'id', 'name' }

    $operationName = 'GetScan'
    if ($queryType -eq 'List') {
        $operationName = 'GetScans'
    }

    $agentField = [Query]::New('agent')
    $parameters['AgentFields'] | ForEach-Object { $agentField.AddField($_) | Out-Null }

    $issueTypesField = [Query]::New('issue_types')
    $parameters['IssueTypesFields'] | ForEach-Object { $issueTypesField.AddField($_) | Out-Null }

    $siteApplicationLoginsField = [Query]::New('site_application_logins')
    $parameters['SiteApplicationLoginsFields'] | ForEach-Object { $siteApplicationLoginsField.AddField($_) | Out-Null }

    $issueCountsField = [Query]::New('issue_counts')
    $parameters['IssueCountsFields'] | ForEach-Object { $issueCountsField.AddField($_) | Out-Null }

    $auditItemsField = [Query]::New('audit_items')
    $parameters['AuditItemsField'] | ForEach-Object { $auditItemsField.AddField($_) | Out-Null }
    $auditItemsField.AddField($issueCountsField) | Out-Null

    $scanConfigurationsField = [Query]::New('scan_configurations')
    $parameters['ScanConfigurationsFields'] | ForEach-Object { $scanConfigurationsField.AddField($_) | Out-Null }

    if ($queryType -eq 'List') {
        $scanField = [Query]::New("scans")
        $scanField.AddArgument('offset', '$offset') | Out-Null
        $scanField.AddArgument('limit', '$limit') | Out-Null
        $scanField.AddArgument('sort_column', '$sort_column') | Out-Null
        $scanField.AddArgument('sort_order', '$sort_order') | Out-Null
        $scanField.AddArgument('scan_status', '$scan_status') | Out-Null
    } else {
        $scanField = [Query]::New("scan")
        $scanField.AddArgument('id', '$id') | Out-Null
    }

    $parameters['Fields'] | ForEach-Object { $scanField.AddField($_) | Out-Null }
    $scanField.AddField($agentField) | Out-Null
    $scanField.AddField($issueTypesField) | Out-Null
    $scanField.AddField($siteApplicationLoginsField) | Out-Null
    $scanField.AddField($auditItemsField) | Out-Null
    $scanField.AddField($scanConfigurationsField) | Out-Null

    $scanQuery = [Query]::New($operationName)
    if ($queryType -eq 'List') {
        $scanQuery.AddArgument('$offset', 'int') | Out-Null
        $scanQuery.AddArgument('$limit', 'int') | Out-Null
        $scanQuery.AddArgument('$sort_column', 'string') | Out-Null
        $scanQuery.AddArgument('$sort_order', 'string') | Out-Null
        $scanQuery.AddArgument('$scan_status', 'string') | Out-Null
    } else {
        $scanQuery.AddArgument('$id', 'ID!') | Out-Null
    }
    $scanQuery.AddField($scanField) | Out-Null

    $query = 'query {0}' -f $scanQuery

    $graphRequest = [GraphRequest]::new($query, $operationName)

    if ($queryType -eq 'List') {
        $graphRequest.Variables.offset = $parameters.Offset
        $graphRequest.Variables.limit = $parameters.Limit
        $graphRequest.Variables.sort_column = $parameters.SortColumn
        $graphRequest.Variables.sort_order = $parameters.SortOrder
        $graphRequest.Variables.scan_status = $parameters.ScanStatus
    }
    else { $graphRequest.Variables.id = $parameters.ID }

    return $graphRequest
}
