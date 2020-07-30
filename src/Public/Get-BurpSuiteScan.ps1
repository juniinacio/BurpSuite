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

        [Parameter(Mandatory = $false,
            ParameterSetName = 'List')]
        [ValidateNotNullOrEmpty()]
        [string]
        $SiteId,

        [Parameter(Mandatory = $false)]
        [ValidateSet('id', 'schedule_item', 'site_id', 'site_name', 'start_time', 'end_time', 'duration_in_seconds', 'status', 'agent', 'scan_metrics',
            'scan_failure_message', 'generated_by', 'scanner_version', 'scan_configurations', 'scan_delta', 'jira_ticket_count', 'issue_types', 'issue_counts',
            'audit_items', 'audit_item', 'scope', 'site_application_logins', 'schedule_item_application_logins', 'issues')]
        [string[]]
        $Fields
    )

    begin {
        if ($PSBoundParameters.ContainsKey('Fields')) {
            $unsupportedFields = @('site_name', 'agent', 'scan_configurations', 'jira_ticket_count', 'issue_types', 'audit_items', 'audit_item', 'scope', 'site_application_logins', 'schedule_item_application_logins', 'issues')
            $equalFields = Compare-Object -ReferenceObject $unsupportedFields -DifferenceObject $Fields -IncludeEqual -ExcludeDifferent -PassThru
            if ($null -ne $equalFields) {
                Write-Warning "Fetching fields ('$($unsupportedFields -join ", '")') is not yet supported."
            }
        } else {
            $Fields = 'id', 'status', 'issue_counts'
        }
    }

    process {
        $arguments = @{}
        if ($PSBoundParameters.ContainsKey('Id')) { $arguments.id = $Id }
        if ($PSBoundParameters.ContainsKey('Offset')) { $arguments.offset = $Offset }
        if ($PSBoundParameters.ContainsKey('Limit')) { $arguments.limit = $Limit }
        if ($PSBoundParameters.ContainsKey('SortColumn')) { $arguments.sort_column = $SortColumn }
        if ($PSBoundParameters.ContainsKey('SortOrder')) { $arguments.sort_order = $SortOrder }
        if ($PSBoundParameters.ContainsKey('ScanStatus')) { $arguments.scan_status = $ScanStatus }
        if ($PSBoundParameters.ContainsKey('SiteId')) { $arguments.site_id = $SiteId }

        if ($PSCmdlet.ParameterSetName -eq 'List') {
            $query = _buildQuery -name 'scans' -objectType 'Scan' -fields $Fields -arguments $arguments
        } else {
            $query = _buildQuery -name 'scan' -alias 'scans' -objectType 'Scan' -fields $Fields -arguments $arguments
        }

        $request = [Request]::new($query)

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.scans
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
