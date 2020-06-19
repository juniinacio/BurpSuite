function Get-BurpSuiteIssue {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ScanId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $SerialNumber,

        [Parameter(Mandatory = $false)]
        [ValidateSet('confidence', 'display_confidence', 'serial_number', 'severity', 'description_html',
            'remediation_html', 'type_index', 'path', 'origin', 'novelty', 'evidence', 'tickets')]
        [string[]]
        $Fields
    )

    begin {
    }

    process {

        $Request = _buildIssueQuery -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $Request.Query)) {
            try {
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.issue
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
