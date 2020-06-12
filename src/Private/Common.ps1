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
        $GraphRequest
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

    $body = _preProcessRequest -GraphRequest $GraphRequest | ConvertTo-Json @convertToJsonArgs

    $params['body'] = $body

    if (_testIsPowerShellCore) { $params.Add('SkipCertificateCheck', $true) }

    Invoke-RestMethod @params
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
        'GraphRequest')
}

function _preProcessRequest {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [Alias('GraphRequest')]
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

# function _createErrorRecord {
#     [CmdletBinding()]
#     Param (
#         [Parameter(Mandatory = $true)]
#         [ValidateNotNull()]
#         [object]
#         $Exception,

#         [Parameter(Mandatory = $true)]
#         [ValidateNotNull()]
#         [ErrorCategory]
#         $ErrorCategory
#     )

#     [ErrorRecord]::new(
#         $Exception,
#         ("BurpSuite.{0}" -f $ErrorCategory),
#         $ErrorCategory,
#         $null
#     )
# }

