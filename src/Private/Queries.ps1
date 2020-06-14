function _buildAgentQuery {
    Param ([hashtable] $parameters)

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

    if ($parameters.ContainsKey('ID')) { $graphRequest.Variables.id = $ID }

    return $graphRequest
}

function _buildIssueQuery {
    Param ([hashtable] $parameters)

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
    Param ([hashtable] $parameters)

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
    Param ([hashtable] $parameters)

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
