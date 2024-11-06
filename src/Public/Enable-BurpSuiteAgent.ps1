function Enable-BurpSuiteAgent {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'EnableAgent' -inputType 'EnableAgentInput!' -name 'enable_agent' -returnType 'Agent'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id
                $variables.input.enabled = $true

                $request = [Request]::new($query, 'EnableAgent', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
