function Get-BurpSuiteAgent {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateSet('id', 'machine_id', 'current_scan_count', 'ip', 'name', 'state', 'enabled', 'max_concurrent_scans')]
        [string[]]
        $Fields,

        [Parameter(Mandatory = $false)]
        [ValidateSet('code', 'error')]
        [string[]]
        $ErrorFields,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ID
    )

    begin {
    }

    process {
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $PSBoundParameters['Fields'] = 'id', 'name', 'state', 'enabled' }

        $operationName = 'GetAgents'
        if ($PSBoundParameters.ContainsKey('ID')) { $operationName = 'GetAgent' }

        $agentFields = [Query]::New('agent')
        $PSBoundParameters['Fields'] | ForEach-Object { $agentFields.AddField($_) | Out-Null }

        if ($PSBoundParameters.ContainsKey('ID')) { $agentFields.AddArgument('id', '$id') | Out-Null }

        if ($PSBoundParameters.ContainsKey('ErrorFields')) {
            $errorField = [Query]::New('error')
            
            $PSBoundParameters['ErrorFields'] | ForEach-Object { $errorField.AddField($_) | Out-Null }

            $agentFields.AddField($errorField) | Out-Null
        }

        $agentQuery = [Query]::New($operationName)
        $agentQuery.AddField($agentFields) | Out-Null

        if ($PSBoundParameters.ContainsKey('ID')) { $agentQuery.AddArgument('$id', 'ID!') | Out-Null }

        $query = 'query {0}' -f $agentQuery

        $graphRequest = [GraphRequest]::new($query, $operationName)

        if ($PSCmdlet.ShouldProcess($graphRequest.Query, "Invoke-BurpSuiteAPI")) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
                $response
            } catch {
                throw
            }
        }
    }

    end {
    }
}
