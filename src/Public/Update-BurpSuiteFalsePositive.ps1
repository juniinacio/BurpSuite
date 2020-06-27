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

        $query = _buildMutation -queryName 'UpdateFalsePositive' -inputType 'UpdateFalsePositiveInput!' -name 'update_false_positive' -returnType 'FalsePositive' -returnTypeField

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }

                $variables.input.scan_id = $ScanId
                $variables.input.serial_number = $SerialNumber
                $variables.input.is_false_positive = "false"
                if ($PSBoundParameters.ContainsKey('IsFalsePositive')) {
                    if ($IsFalsePositive.IsPresent) { $variables.input.is_false_positive = "true" }
                }
                if ($PSBoundParameters.ContainsKey('PropagationMode')) { $variables.input.propagation_mode = $PropagationMode }

                $request = [Request]::new($query, 'UpdateFalsePositive', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
