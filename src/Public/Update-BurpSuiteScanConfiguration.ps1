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

        $graphRequest = _buildUpdateScanConfigurationQuery -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.update_scan_configuration.scan_configuration
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
