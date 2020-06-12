function Get-BurpSuiteScanConfiguration {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateSet('id', 'name', 'scan_configuration_fragment_json', 'built_in', 'last_modified_time', 'last_modified_by')]
        [string[]]
        $Fields
    )

    begin {
    }

    process {
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $PSBoundParameters['Fields'] = 'id', 'name' }

        $operationName = 'GetScanConfigurations'

        $scanConfigurationsField = [Query]::New('scan_configurations')

        $PSBoundParameters['Fields'] | ForEach-Object { $scanConfigurationsField.AddField($_) | Out-Null }

        $scanConfigurationQuery = [Query]::New($operationName)
        $scanConfigurationQuery.AddField($scanConfigurationsField) | Out-Null

        $query = 'query {0}' -f $scanConfigurationQuery.ToString()

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
