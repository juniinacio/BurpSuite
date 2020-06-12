function Invoke-BurpSuiteAPI {
    [CmdletBinding(DefaultParameterSetName = 'Default',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [Alias('Request')]
        [GraphRequest]
        $GraphRequest,

        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'FreeForm')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Query,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'FreeForm')]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Variables
    )

    begin {
    }

    process {
        if ($PSCmdlet.ParameterSetName -eq 'FreeForm') {
            if ($PSBoundParameters.ContainsKey('Variables')) { $graphRequest = [GraphRequest]::new($Query, $Variables) }
            else { $graphRequest = [GraphRequest]::new($Query) }
        }

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

