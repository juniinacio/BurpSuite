function Get-BurpSuiteScanReport {
    [CmdletBinding(DefaultParameterSetName = 'Download',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('Id')]
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
        $arguments = @{}
        $arguments.scan_id = $ScanId
        if ($PSBoundParameters.ContainsKey('TimezoneOffset')) { $arguments.timezone_offset = $TimezoneOffset }
        if ($PSBoundParameters.ContainsKey('ReportType')) { $arguments.report_type = $ReportType }
        if ($PSBoundParameters.ContainsKey('IncludeFalsePositives')) { $arguments.include_false_positives = $IncludeFalsePositives.IsPresent }
        if ($PSBoundParameters.ContainsKey('Severities')) { $arguments.severities = ,@($Severities) }

        $query = _buildQuery -name 'scan_report' -objectType 'ScanReport' -arguments $arguments

        $request = [Request]::new($query)

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
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
