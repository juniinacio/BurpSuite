function Get-BurpSuiteScan {
    [CmdletBinding(DefaultParameterSetName = 'Specific',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Specific')]
        [ValidateNotNullOrEmpty()]
        [string]
        $ID,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'List')]
        [ValidateNotNullOrEmpty()]
        [int]
        $Offset,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'List')]
        [ValidateNotNullOrEmpty()]
        [int]
        $Limit,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'List')]
        [ValidateSet('start', 'end', 'status', 'site', 'id')]
        [string]
        $SortColumn,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'List')]
        [ValidateSet('asc', 'desc')]
        [string]
        $SortOrder,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'List')]
        [ValidateSet('queued', 'running', 'succeeded', 'cancelled', 'failed')]
        [string]
        $ScanStatus,

        [Parameter(Mandatory = $false)]
        [ValidateSet('id', 'schedule_item', 'site_id', 'site_name', 'start_time', 'end_time', 'duration_in_seconds', 'status', 'agent', 'scan_metrics',
            'scan_failure_message', 'generated_by', 'scanner_version', 'scan_configurations', 'scan_delta', 'jira_ticket_count', 'issue_types', 'issue_counts',
            'audit_items', 'audit_item', 'scope', 'site_application_logins', 'schedule_item_application_logins', 'issues')]
        [string[]]
        $Fields
    )

    begin {
    }

    process {

        $graphRequest = _buildScanQuery -Parameters $PSBoundParameters -QueryType $PSCmdlet.ParameterSetName

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
                $response
            } catch {
                throw
            }
        }
    }

    end {
    }
}