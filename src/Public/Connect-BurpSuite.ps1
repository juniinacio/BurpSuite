function Connect-BurpSuite {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    [Alias('Login-BurpSuite')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $APIKey,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Uri,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $PassThru
    )

    begin {
        $uriBuilder = New-Object -TypeName System.UriBuilder -ArgumentList $Uri
        $uriBuilder.Path = '/graphql/v1'

        $graphUrl = $uriBuilder.ToString()
    }

    process {
        $graphRequest = _buildIntrospectionQuery

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                _createSession -APIUrl $graphUrl -APIKey $APIKey
                $response = _callAPI -GraphRequest $graphRequest
                if ($PassThru.IsPresent) {
                    $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                    $data
                }
            } catch {
                _removeSession
                $e = [Exception]::new("Cannot access BurpSuite API using key $APIKey and Uri $Uri")
                throw $e
            }
        }
    }

    end {
    }
}
