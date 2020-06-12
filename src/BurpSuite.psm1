using namespace System.IO
using namespace System.Collections
using namespace System.Collections.Generic
using namespace System.Management.Automation

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

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

