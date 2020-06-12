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
        $Uri
    )

    begin {
        $uriBuilder = New-Object -TypeName System.UriBuilder -ArgumentList $Uri
        $uriBuilder.Path = '/graphql/v1'

        $graphUrl = $uriBuilder.ToString()
        $graphRequest = [GraphRequest]::new('{ __schema { queryType { name } } }')
    }

    process {
        if ($PSCmdlet.ShouldProcess($graphUrl, "Connect to BurpSuite")) {
            try {
                _createSession -APIUrl $graphUrl -APIKey $APIKey
                $null = _callAPI -GraphRequest $graphRequest
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
