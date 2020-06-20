function New-BurpSuiteScanConfiguration {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf })]
        [string]
        $FilePath
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'CreateScanConfiguration' -inputType 'CreateScanConfigurationInput!' -name 'create_scan_configuration' -returnType 'ScanConfiguration'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.name = $Name
                $variables.input.scan_configuration_fragment_json = Get-Content -Raw -Path $FilePath | Out-String

                $request = [Request]::new($query, 'CreateScanConfiguration', $variables)

                $null = _callAPI -Request $Request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
