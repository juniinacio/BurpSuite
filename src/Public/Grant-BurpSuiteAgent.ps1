function Grant-BurpSuiteAgent {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $MachineId
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'AuthorizeAgent' -inputType 'AuthorizeAgentInput!' -name 'authorize_agent' -returnType 'Agent'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.machine_id = $MachineId

                $request = [Request]::new($query, 'AuthorizeAgent', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
