function Set-BurpSuiteAgentMaxConcurrentScan {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [int]
        $MaxConcurrentScans
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'UpdateAgentMaxConcurrentScans' -inputType 'UpdateAgentMaxConcurrentScansInput!' -name 'update_agent_max_concurrent_scans' -returnType 'Agent'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }

                $variables.input.id = $Id
                $variables.input.max_concurrent_scans = $MaxConcurrentScans

                $request = [Request]::new($query, 'UpdateAgentMaxConcurrentScans', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
