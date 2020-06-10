function Connect-BurpSuite {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    [Alias('Login-BurpSuite')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ApiKey,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Uri
    )

    begin {
        $builder = New-Object -TypeName System.UriBuilder -ArgumentList $Uri
        $builder.Path = '/graphql/v1'

        $body = @{
            query = "{ __schema { queryType { name } } }"
        } | ConvertTo-Json -Compress

        $headers = @{
            Authorization  = $ApiKey
            Accept         = 'application/json'
            'Content-Type' = 'application/json'
        }
    }

    process {
        if ($PSCmdlet.ShouldProcess($builder.ToString(), "Connect-BurpSuite")) {
            Invoke-RestMethod -Method POST -Uri $builder.ToString() -Headers $headers -Body $body
        }
    }

    end {
    }
}
