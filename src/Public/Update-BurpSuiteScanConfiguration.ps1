function Update-BurpSuiteScanConfiguration {
    [CmdletBinding(DefaultParameterSetName = 'UpdateName',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'UpdateName')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'AllFields')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'UpdateSettings')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'AllFields')]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf } )]
        [string]
        $FilePath
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'UpdateScanConfiguration' -inputType 'UpdateScanConfigurationInput!' -name 'update_scan_configuration' -returnType 'ScanConfiguration'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id
                if ($PSBoundParameters.ContainsKey('Name')) { $variables.input.name = $Name }
                if ($PSBoundParameters.ContainsKey('FilePath')) { $variables.input.scan_configuration_fragment_json = Get-Content -Raw -Path $FilePath | Out-String }

                $request = [Request]::new($query, 'UpdateScanConfiguration', $variables)

                $response = _callAPI -Request $Request

                $response.data.update_scan_configuration.scan_configuration
            } catch {
                throw
            }
        }
    }

    end {
    }
}
