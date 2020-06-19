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

        $Request = _buildUpdateAgentMaxConcurrentScansQuery -Parameters $PSBoundParameters -queryType $PSCmdlet.ParameterSetName

        if ($PSCmdlet.ShouldProcess("BurpSuite", $Request.Query)) {
            try {
                $response = _callAPI -Request $Request

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
