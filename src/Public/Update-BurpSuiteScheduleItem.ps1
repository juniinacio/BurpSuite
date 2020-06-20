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
        [string] $InitialRunTime,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $RecurrenceRule
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

                if ($PSBoundParameters.ContainsKey('InitialRunTime') -or $PSBoundParameters.ContainsKey('RecurrenceRule')) {
                    $schedule = @{}
                    if ($PSBoundParameters.ContainsKey('InitialRunTime')) { $schedule.initial_run_time = $InitialRunTime }
                    if ($PSBoundParameters.ContainsKey('RecurrenceRule')) { $schedule.rrule = $RecurrenceRule }
                    $variables.input.schedule = $schedule
                }

                $request = [Request]::new($query, 'UpdateScheduleItem', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
