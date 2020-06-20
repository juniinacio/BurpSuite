function Connect-BurpSuite {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    [Alias('Login-BurpSuite')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Uri,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $APIKey,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $PassThru
    )

    begin {
        $uriBuilder = New-Object -TypeName System.UriBuilder -ArgumentList $Uri
        $uriBuilder.Path = '/graphql/v1'

        $apiUrl = $uriBuilder.ToString()
    }

    process {
        $query = _buildQuery -name '__schema' -objectType 'Schema'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                _createSession -APIUrl $apiUrl -APIKey $APIKey
                $request = [Request]::new($query)
                $response = _callAPI -Request $Request
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
