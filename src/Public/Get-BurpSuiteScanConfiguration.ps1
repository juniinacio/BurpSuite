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

        $graphRequest = _buildScanConfigurationQuery -Parameters $PSBoundParameters

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
