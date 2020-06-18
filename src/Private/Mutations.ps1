function _buildCreateScanConfigurationQuery {
    param([hashtable]$parameters)

    $operationName = 'CreateScanConfiguration'

    $scanConfigurationField = [Query]::New('scan_configuration')
    $scanConfigurationField.AddField('id') | Out-Null
    $scanConfigurationField.AddField('name') | Out-Null
    $scanConfigurationField.AddField('scan_configuration_fragment_json') | Out-Null
    $scanConfigurationField.AddField('built_in') | Out-Null
    $scanConfigurationField.AddField((_buildObjectQuery -name 'last_modified_by' -objectType 'User')) | Out-Null
    $scanConfigurationField.AddField('last_modified_time') | Out-Null

    $createScanConfigurationField = [Query]::New('create_scan_configuration')
    $createScanConfigurationField.AddArgument('input', '$input') | Out-Null
    $createScanConfigurationField.AddField($scanConfigurationField) | Out-Null

    $createScanConfigurationQuery = [Query]::New($operationName)
    $createScanConfigurationQuery.AddArgument('$input', 'CreateScanConfigurationInput!') | Out-Null
    $createScanConfigurationQuery.AddField($createScanConfigurationField) | Out-Null

    $query = 'mutation {0}' -f $createScanConfigurationQuery

    $variables = @{input=@{}}
    $variables.input.name = $parameters.Name
    $variables.input.scan_configuration_fragment_json = Get-Content -Raw -Path $parameters.FilePath | Out-String

    $graphRequest = [GraphRequest]::new($query, $operationName, $variables)

    return $graphRequest
}

function _buildUpdateScanConfigurationQuery {
    param([hashtable]$parameters)

    $operationName = 'UpdateScanConfiguration'

    $scanConfigurationField = [Query]::New('scan_configuration')
    $scanConfigurationField.AddField('id') | Out-Null
    $scanConfigurationField.AddField('name') | Out-Null
    $scanConfigurationField.AddField('scan_configuration_fragment_json') | Out-Null
    $scanConfigurationField.AddField('built_in') | Out-Null
    $scanConfigurationField.AddField((_buildObjectQuery -name 'last_modified_by' -objectType 'User')) | Out-Null
    $scanConfigurationField.AddField('last_modified_time') | Out-Null

    $updateScanConfigurationField = [Query]::New('update_scan_configuration')
    $updateScanConfigurationField.AddArgument('input', '$input') | Out-Null
    $updateScanConfigurationField.AddField($scanConfigurationField) | Out-Null

    $updateScanConfigurationQuery = [Query]::New($operationName)
    $updateScanConfigurationQuery.AddArgument('$input', 'UpdateScanConfigurationInput!') | Out-Null
    $updateScanConfigurationQuery.AddField($updateScanConfigurationField) | Out-Null

    $query = 'mutation {0}' -f $updateScanConfigurationQuery

    $variables = @{input=@{}}

    $variables.input.id = $parameters.Id
    if ($parameters.ContainsKey('Name')) { $variables.input.name = $parameters.Name }
    if ($parameters.ContainsKey('FilePath')) { $variables.input.scan_configuration_fragment_json = Get-Content -Raw -Path $parameters.FilePath | Out-String }

    $graphRequest = [GraphRequest]::new($query, $operationName, $variables)

    return $graphRequest
}

function _buildDeleteScanConfigurationQuery {
    param([hashtable]$parameters)

    $operationName = 'DeleteScanConfiguration'

    $deleteScanConfigurationField = [Query]::New('delete_scan_configuration')
    $deleteScanConfigurationField.AddArgument('input', '$input') | Out-Null
    $deleteScanConfigurationField.AddField('id') | Out-Null

    $deleteScanConfigurationQuery = [Query]::New($operationName)
    $deleteScanConfigurationQuery.AddArgument('$input', 'DeleteScanConfigurationInput!') | Out-Null
    $deleteScanConfigurationQuery.AddField($deleteScanConfigurationField) | Out-Null

    $query = 'mutation {0}' -f $deleteScanConfigurationQuery

    $variables = @{input=@{}}

    $variables.input.id = $parameters.Id

    $graphRequest = [GraphRequest]::new($query, $operationName, $variables)

    return $graphRequest
}

function _buildDeleteScheduleItemQuery {
    param([hashtable]$parameters)

    $operationName = 'DeleteScheduleItem'

    $deleteScheduleItemField = [Query]::New('delete_schedule_item')
    $deleteScheduleItemField.AddArgument('input', '$input') | Out-Null
    $deleteScheduleItemField.AddField('id') | Out-Null

    $deleteScheduleItemQuery = [Query]::New($operationName)
    $deleteScheduleItemQuery.AddArgument('$input', 'DeleteScheduleItemInput!') | Out-Null
    $deleteScheduleItemQuery.AddField($deleteScheduleItemField) | Out-Null

    $query = 'mutation {0}' -f $deleteScheduleItemQuery

    $variables = @{input=@{}}

    $variables.input.id = $parameters.Id

    $graphRequest = [GraphRequest]::new($query, $operationName, $variables)

    return $graphRequest
}
