function Update-BurpSuiteFalsePositive {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $ScanId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $SerialNumber,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [switch] $IsFalsePositive,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('none', 'issue_type_only', 'issue_type_and_url')]
        [string] $PropagationMode
    )

    begin {
    }

    process {

        $Request = _buildUpdateFalsePositive -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $Request.Query)) {
            try {
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.update_false_positive
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
