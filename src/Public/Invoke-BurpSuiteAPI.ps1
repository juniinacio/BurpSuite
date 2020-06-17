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
        [object]
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
            $GraphRequest = [GraphRequest]::new($Query)
            if ($PSBoundParameters.ContainsKey('Variables')) {
                $GraphRequest.Variables = $Variables
            }
        }

        if ($PSCmdlet.ShouldProcess("BurpSuite", $GraphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $GraphRequest
                $response
            } catch {
                throw
            }
        }
    }

    end {
    }
}

