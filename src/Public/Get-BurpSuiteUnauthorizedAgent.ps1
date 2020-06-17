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

        $graphRequest = _buildUnauthorizedAgentQuery -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
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
