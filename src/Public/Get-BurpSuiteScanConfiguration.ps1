function Get-BurpSuiteScanConfiguration {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateSet('id', 'name', 'scan_configuration_fragment_json', 'built_in', 'last_modified_time', 'last_modified_by')]
        [string[]]
        $Fields,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ID
    )

    begin {
    }

    process {
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $PSBoundParameters['Fields'] = 'id', 'name' }

        $operationName = 'GetScanConfigurations'
        if ($PSBoundParameters.ContainsKey('ID')) { $operationName = 'GetScanConfiguration' }

        $scanConfigurationsField = [Query]::New('scan_configurations')
        $PSBoundParameters['Fields'] | ForEach-Object { $scanConfigurationsField.AddField($_) | Out-Null }

        if ($PSBoundParameters.ContainsKey('ID')) { $scanConfigurationsField.AddArgument('scan_id', '$scanId') | Out-Null }

        $scanConfigurationQuery = [Query]::New($operationName)
        $scanConfigurationQuery.AddField($scanConfigurationsField) | Out-Null

        if ($PSBoundParameters.ContainsKey('ID')) { $scanConfigurationQuery.AddArgument('$scanId', 'ID!') | Out-Null }

        $query = 'query {0}' -f $scanConfigurationQuery.ToString()

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
