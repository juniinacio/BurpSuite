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

        $Request = _buildUnauthorizedAgentQuery -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $Request.Query)) {
            try {
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
