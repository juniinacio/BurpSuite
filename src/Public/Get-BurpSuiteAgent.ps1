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
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $Fields = 'id', 'name', 'state', 'enabled' }
    }

    process {

        if ($PSCmdlet.ParameterSetName -eq 'List') {
            $query = _queryableObject -name 'agents' -objectType 'Agent' -fields $Fields -arguments @{}
        } else {
            $query = _queryableObject -name 'agent' -alias 'agents' -objectType 'Agent' -fields $Fields -arguments @{id = $Id }
        }

        $request = [Request]::new($query)

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $response = _callAPI -Request $request

                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.agents
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
