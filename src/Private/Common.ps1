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

    $params['body'] = $GraphRequest | ConvertTo-Json

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
