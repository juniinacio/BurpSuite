function Revoke-BurpSuiteAgent {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $MachineId
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'DeauthorizeAgent' -inputType 'DeauthorizeAgentInput!' -name 'deauthorize_agent' -returnType 'Id' -returnTypeField

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.machine_id = $MachineId

                $request = [Request]::new($query, 'DeauthorizeAgent', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
