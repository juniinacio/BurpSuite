using namespace System.IO
using namespace System.Collections
using namespace System.Collections.Generic
using namespace System.Management.Automation

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

[ReflectionCache]::TypeAccelerators::Add(
    'GraphQLRequest',
    [GraphQLRequest])

$ExecutionContext.SessionState.Module.OnRemove = {
    [ReflectionCache]::TypeAccelerators::Remove('GraphQLRequest')
}
