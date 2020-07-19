function Invoke-BurpSuiteAPI {
    [CmdletBinding(DefaultParameterSetName = 'Default',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [object]
        $Request,

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
            $Request = [Request]::new($Query)
            if ($PSBoundParameters.ContainsKey('Variables')) { $Request.Variables = $Variables }
        }

        if ($PSCmdlet.ShouldProcess("BurpSuite", $Request.Query)) {
            try {
                $response = _callAPI -Request $Request
                $response
            } catch {
                throw
            }
        }
    }

    end {
    }
}

