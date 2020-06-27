function Get-BurpSuiteScheduleItem {
    [CmdletBinding(DefaultParameterSetName = 'List',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Specific')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'List')]
        [ValidateNotNullOrEmpty()]
        [string]
        $SortBy,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'List')]
        [ValidateNotNullOrEmpty()]
        [string]
        $SortOrder,

        [Parameter(Mandatory = $false)]
        [ValidateSet('id', 'site', 'schedule', 'scan_configurations', 'has_run_more_than_once', 'scheduled_run_time')]
        [string[]]
        $Fields
    )

    begin {
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $Fields = 'id', 'schedule', 'scheduled_run_time' }
    }

    process {
        $arguments = @{}
        if ($PSBoundParameters.ContainsKey('Id')) { $arguments.id = $Id }
        if ($PSBoundParameters.ContainsKey('SortBy')) { $arguments.sort_by = $SortBy }
        if ($PSBoundParameters.ContainsKey('SortOrder')) { $arguments.sort_order = $SortOrder }

        if ($PSCmdlet.ParameterSetName -eq 'List') {
            $query = _buildQuery -name 'schedule_items' -objectType 'ScheduleItem' -fields $Fields -arguments $arguments
        } else {
            $query = _buildQuery -name 'schedule_item' -alias 'schedule_items' -objectType 'ScheduleItem' -fields $Fields -arguments $arguments
        }

        $request = [Request]::new($query)

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.schedule_items
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
