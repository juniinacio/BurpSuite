function New-BurpSuiteScheduleItem {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
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

        $query = _buildMutation -queryName 'CreateScheduleItem' -inputType 'CreateScheduleItemInput!' -name 'create_schedule_item' -returnType 'ScheduleItem'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.site_id = $SiteId
                $variables.input.scan_configuration_ids = $ScanConfigurationIds

                if ($PSBoundParameters.ContainsKey('Schedule')) {
                    $scheduleInput = @{}

                    $initialRunTime = _getObjectProperty -InputObject $Schedule -PropertyName 'InitialRunTime'
                    if ($null -ne $initialRunTime) { $scheduleInput.initial_run_time = $initialRunTime }

                    $recurrenceRule = _getObjectProperty -InputObject $Schedule -PropertyName 'RRule'
                    if ($null -ne $recurrenceRule) { $scheduleInput.rrule = $recurrenceRule }

                    $variables.input.schedule = $scheduleInput
                }

                $request = [Request]::new($query, 'CreateScheduleItem', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
