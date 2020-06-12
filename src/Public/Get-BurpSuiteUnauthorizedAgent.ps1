function Get-BurpSuiteUnauthorizedAgent {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateSet('machine_id', 'ip')]
        [string[]]
        $Fields
    )

    begin {
    }

    process {
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $PSBoundParameters['Fields'] = 'ip' }

        $operationName = 'GetUnauthorizedAgents'

        $unauthorizedAgentsField = [Query]::New('unauthorized_agents')
        $PSBoundParameters['Fields'] | ForEach-Object { $unauthorizedAgentsField.AddField($_) | Out-Null }

        $unauthorizedAgentsQuery = [Query]::New($operationName)
        $unauthorizedAgentsQuery.AddField($unauthorizedAgentsField) | Out-Null

        $query = 'query {0}' -f $unauthorizedAgentsQuery

        $graphRequest = [GraphRequest]::new($query, $operationName)

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
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
