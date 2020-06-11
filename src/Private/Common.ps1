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
        [GraphQLRequest]
        $GraphQLRequest
    )

    _hasUri

    $params = @{ }
    $params.Add('Uri', [Session]::APIUrl)

    $params.Add('Headers', @{ })
    $params['Headers'].Add('Authorization', [Session]::APIKey)

    $params['Body'] = $GraphQLRequest | ConvertTo-Json

    Invoke-RestMethod @params
}

function _removeSession {
    [CmdletBinding()]
    Param (
    )

    [Session]::Dispose()
}

function _hasUri {
    param (
    )
    if (-not [Session]::APIUrl) {
        $e = [Exception]::New('You must call Connect-BurpSuite before calling any other function in this module.')
        throw $e
    }
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
