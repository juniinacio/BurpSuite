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
