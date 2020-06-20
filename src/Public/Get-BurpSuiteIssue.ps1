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
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $Fields = 'confidence', 'serial_number', 'severity', 'novelty' }
    }

    process {
        $arguments = @{}
        $arguments.scan_id = $ScanId
        $arguments.serial_number = $SerialNumber
        $query = _queryableObject -name 'issue' -objectType 'Issue' -fields $Fields -arguments $arguments

        $request = [Request]::new($query)

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $response = _callAPI -Request $request
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
