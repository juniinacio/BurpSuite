using namespace System.IO
using namespace System.Collections
using namespace System.Collections.Generic
using namespace System.Management.Automation

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

function _getPowerShellVersion {
    param (
    )

    return $PSVersionTable.PSVersion
}

function _testIsPowerShellCore {
    param (
    )

    if ((_getPowerShellVersion).Major -ge 6) {
        return $true
    }

    return $false
}

if (-not (_testIsPowerShellCore)) {
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
}

function _registerAccelerators {
    param (
    )

    [ReflectionCache]::TypeAccelerators::Add(
        'GraphRequest',
        [GraphRequest])
}
_registerAccelerators

$ExecutionContext.SessionState.Module.OnRemove = {
    _uregisterAccelerators
}

