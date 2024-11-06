function Update-BurpSuiteScheduleItem {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $SiteId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]] $ScanConfigurationIds,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [psobject] $Schedule
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'UpdateScheduleItem' -inputType 'UpdateScheduleItemInput!' -name 'update_schedule_item' -returnType 'ScheduleItem'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id
                $variables.input.site_id = $SiteId
                $variables.input.scan_configuration_ids = $ScanConfigurationIds

                if ($PSBoundParameters.ContainsKey('SiteId')) { $variables.input.site_id = $SiteId }

                if ($PSBoundParameters.ContainsKey('Schedule')) {
                    $scheduleInput = @{}

                    $initialRunTime = _getObjectProperty -InputObject $Schedule -PropertyName 'InitialRunTime'
                    if ($null -ne $initialRunTime) {
                        $scheduleInput.initial_run_time = $initialRunTime
                        $scheduleInput.initial_run_time_is_set = $true
                    }

                    $recurrenceRule = _getObjectProperty -InputObject $Schedule -PropertyName 'RRule'
                    if ($null -ne $recurrenceRule) {
                        $scheduleInput.rrule = $recurrenceRule
                        $scheduleInput.rrule_is_set = $true
                    }

                    $variables.input.schedule = $scheduleInput
                }

                $request = [Request]::new($query, 'UpdateScheduleItem', $variables)

                $response = _callAPI -Request $request
                $response.data.update_schedule_item.schedule_item
            } catch {
                throw
            }
        }
    }

    end {
    }
}
