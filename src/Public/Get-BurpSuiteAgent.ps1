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

        $graphRequest = _buildAgentQuery -Parameters $PSBoundParameters

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
