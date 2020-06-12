function Invoke-BurpSuiteAPI {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('Request')]
        [GraphRequest]
        $GraphRequest
    )

    begin {
    }

    process {
        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
                $response
            } catch {
                throw
            }
        }
    }

    end {
    }
}
