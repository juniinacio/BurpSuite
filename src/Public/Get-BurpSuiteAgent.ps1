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

        if ($PSCmdlet.ParameterSetName -eq 'List') {
            $queryName = 'GetAgents'
        } else {
            $queryName = 'GetAgent'
        }

        $query = _buildAgentQuery -queryName $queryName -selectFields $PSBoundParameters['Fields'] -queryType $PSCmdlet.ParameterSetName

        $request = [GraphRequest]::new($query, $queryName)

        if ($PSCmdlet.ParameterSetName -eq 'Specific') {
            $request.Variables.id = $Id
        }

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $response = _callAPI -GraphRequest $request

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
