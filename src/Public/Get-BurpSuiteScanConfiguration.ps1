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
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $Fields = 'id', 'name' }
    }

    process {
        $query = _buildQuery -name 'scan_configurations' -objectType 'ScanConfiguration' -fields $Fields

        $request = [Request]::new($query)

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.scan_configurations
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
