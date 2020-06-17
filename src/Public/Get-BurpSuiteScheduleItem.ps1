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
    }

    process {

        $graphRequest = _buildScheduleItemQuery -Parameters $PSBoundParameters -QueryType $PSCmdlet.ParameterSetName

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    if ($PSCmdlet.ParameterSetName -eq 'List') {
                        $data.schedule_items
                    } else {
                        $data.schedule_item
                    }
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
