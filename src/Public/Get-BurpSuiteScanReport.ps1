function Get-BurpSuiteScanReport {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ID,

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
                $response
            } catch {
                throw
            }
        }
    }

    end {
    }
}
