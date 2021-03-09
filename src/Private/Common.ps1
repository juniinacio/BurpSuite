function _createSession {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $APIUrl,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $APIKey
    )

    [Session]::Create($APIKey, $APIUrl)
}

function _callAPI {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [object]
        $Request
    )

    _assertAPIKey
    _assertAPIUrl

    $params = @{ }

    $params['uri'] = [Session]::APIUrl
    $params['method'] = 'Post'

    $params['headers'] = @{ }

    $params['headers']['authorization'] = [Session]::APIKey
    $params['headers']['content-type'] = 'application/json'
    $params['headers']['accept'] = 'application/json'

    $convertToJsonArgs = @{}
    if (_testIsPowerShellCore) { $convertToJsonArgs['Compress'] = $true }

    $body = _preProcessRequest -Request $Request | ConvertTo-Json @convertToJsonArgs -Depth 5

    $params['body'] = $body
    Write-Verbose $body

    if (_testIsPowerShellCore) { $params.Add('SkipCertificateCheck', $true) }

    $response = Invoke-RestMethod @params
    if ((_testObjectProperty -InputObject $response -PropertyName 'errors')) {
        $exceptions = @()
        foreach ($e in $response.errors) { $exceptions += [Exception]::New($e.message) }
        $aggregate = [AggregateException]::new("One or more errors occurred while querying BurpSuite.", $exceptions)
        throw $aggregate
    } else {
        Write-Verbose $($response | ConvertTo-Json -Depth 99)
        $response
    }
}

function _removeSession {
    [CmdletBinding()]
    Param (
    )

    [Session]::Dispose()
}

function _assertAPIKey {
    param (
    )

    if (-not [Session]::APIKey) {
        $e = [Exception]::New('You must call Connect-BurpSuite before calling any other function in this module.')
        throw $e
    }
}

function _assertAPIUrl {
    param (
    )

    if (-not [Session]::APIUrl) {
        $e = [Exception]::New('You must call Connect-BurpSuite before calling any other function in this module.')
        throw $e
    }
}

function _uregisterAccelerators {
    param (
    )

    [ReflectionCache]::TypeAccelerators::Remove(
        'BurpSuiteRequest')
}

function _preProcessRequest {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [Alias('Request')]
        [object]
        $InputObject
    )

    $properties = @{}
    $InputObject | Get-Member -MemberType Properties | ForEach-Object {
        $propertyName = $_.Name
        $propertyValue = $InputObject.$propertyName
        switch ($propertyValue) {
            { $_ -is [IEnumerable] -or $_ -is [IDictionary] } {
                if ($propertyValue.Count -gt 0) {
                    $properties[$propertyName.ToLowerInvariant()] = $propertyValue
                }
            }
            default {
                if ($null -ne $propertyValue) {
                    $properties[$propertyName.ToLowerInvariant()] = $propertyValue
                }
            }
        }
    }
    [PSCustomObject]$properties
}

