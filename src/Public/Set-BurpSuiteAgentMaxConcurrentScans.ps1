function Set-BurpSuiteAgentMaxConcurrentScans {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [int]
        $MaxConcurrentScans
    )

    begin {
    }

    process {

        $graphRequest = _buildUpdateAgentMaxConcurrentScansQuery -Parameters $PSBoundParameters -queryType $PSCmdlet.ParameterSetName

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest

                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.agent
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
