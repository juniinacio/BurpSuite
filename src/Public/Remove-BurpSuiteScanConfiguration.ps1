function Remove-BurpSuiteScanConfiguration {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'DeleteScanConfiguration' -inputType 'DeleteScanConfigurationInput!' -name 'delete_scan_configuration' -returnType 'ScanConfiguration' -returnTypeField

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id

                $request = [Request]::new($query, 'DeleteScanConfiguration', $variables)

                $response = _callAPI -Request $Request

                $response.data.delete_scan_configuration
            } catch {
                throw
            }
        }
    }

    end {
    }
}
