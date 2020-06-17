function Update-BurpSuiteScanConfiguration {
    [CmdletBinding(DefaultParameterSetName = 'UpdateName',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id,

        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateName')]
        [Parameter(Mandatory = $true, ParameterSetName = 'AllFields')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateSettings')]
        [Parameter(Mandatory = $true, ParameterSetName = 'AllFields')]
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
