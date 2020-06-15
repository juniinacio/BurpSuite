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
        $ScanStatus
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
