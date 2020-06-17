function Get-BurpSuiteAgent {
    [CmdletBinding(DefaultParameterSetName = 'List',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateSet('id', 'machine_id', 'current_scan_count', 'ip', 'name', 'state', 'error', 'enabled', 'max_concurrent_scans')]
        [string[]]
        $Fields,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Specific')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id
    )

    begin {
    }

    process {

        $graphRequest = _buildAgentQuery -Parameters $PSBoundParameters -queryType $PSCmdlet.ParameterSetName

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest

                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    if ($PSCmdlet.ParameterSetName -eq 'List') {
                        $data.agents
                    } else {
                        $data.agent
                    }
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
