function Get-BurpSuiteScanReport {
    [CmdletBinding(DefaultParameterSetName = 'Download',
        SupportsShouldProcess = $true,
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
        $Severities,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'DownloadToDisk')]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf -IsValid })]
        [string]
        $OutFile
    )

    begin {
    }

    process {
        $Request = _buildScanReportQuery -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $Request.Query)) {
            try {
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    if ($PSCmdlet.ParameterSetName -eq 'Download') {
                        $data.scan_report
                    } else {
                        $outFileArgs = @{}
                        $outFileArgs.FilePath = $OutFile
                        $data.scan_report.report_html | Out-File @outFileArgs
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
