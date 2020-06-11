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

        $graphQLUri = $uriBuilder.ToString()

        $graphQLRequest = [GraphQLRequest]::new('{ __schema { queryType { name } } }')
    }

    process {
        if ($PSCmdlet.ShouldProcess($graphQLUri, "Connect to BurpSuite")) {
            try {
                _createSession -APIUrl $graphQLUri -APIKey $APIKey
                $null = _callAPI -GraphQLRequest $graphQLRequest
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
