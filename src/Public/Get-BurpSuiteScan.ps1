function Get-BurpSuiteScan {
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
        [int]
        $Offset,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'List')]
        [ValidateNotNullOrEmpty()]
        [int]
        $Limit,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'List')]
        [ValidateSet('start', 'end', 'status', 'site', 'id')]
        [string]
        $SortColumn,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'List')]
        [ValidateSet('asc', 'desc')]
        [string]
        $SortOrder,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'List')]
        [ValidateSet('queued', 'running', 'succeeded', 'cancelled', 'failed')]
        [string[]]
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

        if ($PSBoundParameters.ContainsKey('Fields')) {
            $unsupportedFields = @('site_name', 'agent', 'scan_configurations', 'jira_ticket_count', 'issue_types', 'audit_items', 'audit_item', 'scope', 'site_application_logins', 'schedule_item_application_logins', 'issues')
            $equalFields = Compare-Object -ReferenceObject $unsupportedFields -DifferenceObject $Fields -IncludeEqual -ExcludeDifferent -PassThru
            if ($null -ne $equalFields) {
                Write-Warning "Fetching fields ('$($unsupportedFields -join ", '")') is not yet supported."
            }
        }

        $Request = _buildScanQuery -Parameters $PSBoundParameters -QueryType $PSCmdlet.ParameterSetName

        if ($PSCmdlet.ShouldProcess("BurpSuite", $Request.Query)) {
            try {
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    if ($PSCmdlet.ParameterSetName -eq 'List') {
                        $data.scans
                    } else {
                        $data.scan
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
