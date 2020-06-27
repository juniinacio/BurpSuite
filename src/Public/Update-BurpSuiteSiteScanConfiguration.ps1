function Update-BurpSuiteSiteScanConfiguration {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]] $ScanConfigurationIds
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'UpdateSiteScanConfigurations' -inputType 'UpdateSiteScanConfigurationsInput!' -name 'update_site_scan_configurations' -returnType 'Site'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id
                $variables.input.scan_configuration_ids = $ScanConfigurationIds

                $request = [Request]::new($query, 'UpdateSiteScanConfigurations', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
