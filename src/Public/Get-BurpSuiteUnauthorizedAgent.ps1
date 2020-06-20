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
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $Fields = 'ip' }
    }

    process {
        $query = _buildQuery -name 'unauthorized_agents' -objectType 'UnauthorizedAgent' -fields $Fields

        if ($PSCmdlet.ShouldProcess("BurpSuite", $Request.Query)) {
            try {
                $request = [Request]::new($query)
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.unauthorized_agents
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
