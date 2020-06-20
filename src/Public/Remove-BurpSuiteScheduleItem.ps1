function Remove-BurpSuiteScheduleItem {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'DeleteScheduleItem' -inputType 'DeleteScheduleItemInput!' -name 'delete_schedule_item' -returnType 'ScheduleItem' -returnTypeField

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{input = @{} }
                $variables.input.id = $Id

                $request = [Request]::new($query, 'DeleteScheduleItem', $variables)

                $response = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
