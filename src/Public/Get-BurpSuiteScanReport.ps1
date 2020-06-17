function Get-BurpSuiteScanReport {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ScanId,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [int]
        $TimezoneOffset,

        [Parameter(Mandatory = $false)]
        [ValidateSet('detailed', 'summary')]
        [string]
        $ReportType,

        [Parameter(Mandatory = $false)]
        [switch]
        $IncludeFalsePositives,

        [Parameter(Mandatory = $false)]
        [ValidateSet('info', 'low', 'medium', 'high')]
        [string[]]
        $Severities
    )

    begin {
    }

    process {
        $graphRequest = _buildScanReportQuery -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.scan_report
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
