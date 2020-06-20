function _buildCreateScanConfigurationQuery {
    param([hashtable]$parameters)

    $operationName = 'CreateScanConfiguration'

    $scanConfigurationField = [Query]::New('scan_configuration')
    $scanConfigurationField.AddField('id') | Out-Null
    $scanConfigurationField.AddField('name') | Out-Null
    $scanConfigurationField.AddField('scan_configuration_fragment_json') | Out-Null
    $scanConfigurationField.AddField('built_in') | Out-Null
    $scanConfigurationField.AddField((_buildQueryField -name 'last_modified_by' -objectType 'User')) | Out-Null
    $scanConfigurationField.AddField('last_modified_time') | Out-Null

    $createScanConfigurationField = [Query]::New('create_scan_configuration')
    $createScanConfigurationField.AddArgument('input', '$input') | Out-Null
    $createScanConfigurationField.AddField($scanConfigurationField) | Out-Null

    $createScanConfigurationQuery = [Query]::New($operationName)
    $createScanConfigurationQuery.AddArgument('$input', 'CreateScanConfigurationInput!') | Out-Null
    $createScanConfigurationQuery.AddField($createScanConfigurationField) | Out-Null

    $query = 'mutation {0}' -f $createScanConfigurationQuery

    $variables = @{input = @{} }
    $variables.input.name = $parameters.Name
    $variables.input.scan_configuration_fragment_json = Get-Content -Raw -Path $parameters.FilePath | Out-String

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
}

function _buildUpdateScanConfigurationQuery {
    param([hashtable]$parameters)

    $operationName = 'UpdateScanConfiguration'

    $scanConfigurationField = [Query]::New('scan_configuration')
    $scanConfigurationField.AddField('id') | Out-Null
    $scanConfigurationField.AddField('name') | Out-Null
    $scanConfigurationField.AddField('scan_configuration_fragment_json') | Out-Null
    $scanConfigurationField.AddField('built_in') | Out-Null
    $scanConfigurationField.AddField((_buildQueryField -name 'last_modified_by' -objectType 'User')) | Out-Null
    $scanConfigurationField.AddField('last_modified_time') | Out-Null

    $updateScanConfigurationField = [Query]::New('update_scan_configuration')
    $updateScanConfigurationField.AddArgument('input', '$input') | Out-Null
    $updateScanConfigurationField.AddField($scanConfigurationField) | Out-Null

    $updateScanConfigurationQuery = [Query]::New($operationName)
    $updateScanConfigurationQuery.AddArgument('$input', 'UpdateScanConfigurationInput!') | Out-Null
    $updateScanConfigurationQuery.AddField($updateScanConfigurationField) | Out-Null

    $query = 'mutation {0}' -f $updateScanConfigurationQuery

    $variables = @{input = @{} }

    $variables.input.id = $parameters.Id
    if ($parameters.ContainsKey('Name')) { $variables.input.name = $parameters.Name }
    if ($parameters.ContainsKey('FilePath')) { $variables.input.scan_configuration_fragment_json = Get-Content -Raw -Path $parameters.FilePath | Out-String }

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
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

    $variables = @{input = @{} }

    $variables.input.id = $parameters.Id

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
}

function _buildCreateScheduleItemQuery {
    param([hashtable]$parameters)

    $operationName = 'CreateScheduleItem'

    $scheduleItemField = [Query]::New('schedule_item')
    $scheduleItemField.AddField('id') | Out-Null

    $createScheduleItemField = [Query]::New('create_schedule_item')
    $createScheduleItemField.AddArgument('input', '$input') | Out-Null
    $createScheduleItemField.AddField($scheduleItemField) | Out-Null

    $createScheduleItemQuery = [Query]::New($operationName)
    $createScheduleItemQuery.AddArgument('$input', 'CreateScheduleItemInput!') | Out-Null
    $createScheduleItemQuery.AddField($createScheduleItemField) | Out-Null

    $query = 'mutation {0}' -f $createScheduleItemQuery

    $variables = @{input = @{} }
    $variables.input.site_id = $parameters.SiteId
    $variables.input.scan_configuration_ids = $parameters.ScanConfigurationIds

    if ($parameters.ContainsKey('InitialRunTime') -or $parameters.ContainsKey('RecurrenceRule')) {
        $schedule = @{}
        if ($parameters.ContainsKey('InitialRunTime')) { $schedule.initial_run_time = $parameters.InitialRunTime }
        if ($parameters.ContainsKey('RecurrenceRule')) { $schedule.rrule = $parameters.RecurrenceRule }
        $variables.input.schedule = $schedule
    }

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
}

function _buildUpdateScheduleItemQuery {
    param([hashtable]$parameters)

    $operationName = 'UpdateScheduleItem'

    $scheduleItemField = [Query]::New('schedule_item')
    $scheduleItemField.AddField('id') | Out-Null

    $updateScheduleItemField = [Query]::New('update_schedule_item')
    $updateScheduleItemField.AddArgument('input', '$input') | Out-Null
    $updateScheduleItemField.AddField($scheduleItemField) | Out-Null

    $updateScheduleItemQuery = [Query]::New($operationName)
    $updateScheduleItemQuery.AddArgument('$input', 'UpdateScheduleItemInput!') | Out-Null
    $updateScheduleItemQuery.AddField($updateScheduleItemField) | Out-Null

    $query = 'mutation {0}' -f $updateScheduleItemQuery

    $variables = @{input = @{} }
    $variables.input.id = $parameters.Id
    $variables.input.scan_configuration_ids = $parameters.ScanConfigurationIds

    if ($parameters.ContainsKey('SiteId')) { $variables.input.site_id = $parameters.SiteId }

    if ($parameters.ContainsKey('InitialRunTime') -or $parameters.ContainsKey('RecurrenceRule')) {
        $schedule = @{}
        if ($parameters.ContainsKey('InitialRunTime')) { $schedule.initial_run_time = $parameters.InitialRunTime }
        if ($parameters.ContainsKey('RecurrenceRule')) { $schedule.rrule = $parameters.RecurrenceRule }
        $variables.input.schedule = $schedule
    }

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
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

    $variables = @{input = @{} }

    $variables.input.id = $parameters.Id

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
}

function _buildDeleteScanQuery {
    param([hashtable]$parameters)

    $operationName = 'DeleteScan'

    $deleteScanField = [Query]::New('delete_scan')
    $deleteScanField.AddArgument('input', '$input') | Out-Null
    $deleteScanField.AddField('id') | Out-Null

    $deleteScanQuery = [Query]::New($operationName)
    $deleteScanQuery.AddArgument('$input', 'DeleteScanInput!') | Out-Null
    $deleteScanQuery.AddField($deleteScanField) | Out-Null

    $query = 'mutation {0}' -f $deleteScanQuery

    $variables = @{input = @{} }

    $variables.input.id = $parameters.Id

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
}

function _buildCancelScanQuery {
    param([hashtable]$parameters)

    $operationName = 'CancelScan'

    $deleteScanField = [Query]::New('cancel_scan')
    $deleteScanField.AddArgument('input', '$input') | Out-Null
    $deleteScanField.AddField('id') | Out-Null

    $deleteScanQuery = [Query]::New($operationName)
    $deleteScanQuery.AddArgument('$input', 'CancelScanInput!') | Out-Null
    $deleteScanQuery.AddField($deleteScanField) | Out-Null

    $query = 'mutation {0}' -f $deleteScanQuery

    $variables = @{input = @{} }

    $variables.input.id = $parameters.Id

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
}

function _buildUpdateFalsePositive {
    param([hashtable]$parameters)

    $operationName = 'UpdateFalsePositive'

    $updateFalsePositiveField = [Query]::New('update_false_positive')
    $updateFalsePositiveField.AddArgument('input', '$input') | Out-Null
    $updateFalsePositiveField.AddField('successful') | Out-Null

    $updateFalsePositiveQuery = [Query]::New($operationName)
    $updateFalsePositiveQuery.AddArgument('$input', 'UpdateFalsePositiveInput!') | Out-Null
    $updateFalsePositiveQuery.AddField($updateFalsePositiveField) | Out-Null

    $query = 'mutation {0}' -f $updateFalsePositiveQuery

    $variables = @{ input = @{} }

    $variables.input.scan_id = $parameters.ScanId
    $variables.input.serial_number = $parameters.SerialNumber
    $variables.input.is_false_positive = "false"
    if ($parameters.ContainsKey('IsFalsePositive')) {
        if ($parameters.IsFalsePositive -eq $true) { $variables.input.is_false_positive = "true" }
    }
    if ($parameters.ContainsKey('PropagationMode')) { $variables.input.propagation_mode = $parameters.PropagationMode }

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
}

function _buildUpdateAgentMaxConcurrentScansQuery {
    param([hashtable]$parameters)

    $operationName = 'UpdateAgentMaxConcurrentScans'

    $agentField = [Query]::New('agent')
    $agentField.AddField('id') | Out-Null
    $agentField.AddField('name') | Out-Null
    $agentField.AddField('max_concurrent_scans') | Out-Null
    $agentField.AddField('enabled') | Out-Null

    $updateAgentMaxConcurrentScansField = [Query]::New('update_agent_max_concurrent_scans')
    $updateAgentMaxConcurrentScansField.AddArgument('input', '$input') | Out-Null
    $updateAgentMaxConcurrentScansField.AddField($agentField) | Out-Null

    $updateAgentMaxConcurrentScansQuery = [Query]::New($operationName)
    $updateAgentMaxConcurrentScansQuery.AddArgument('$input', 'UpdateAgentMaxConcurrentScansInput!') | Out-Null
    $updateAgentMaxConcurrentScansQuery.AddField($updateAgentMaxConcurrentScansField) | Out-Null

    $query = 'mutation {0}' -f $updateAgentMaxConcurrentScansQuery

    $variables = @{ input = @{} }

    $variables.input.id = $parameters.Id
    $variables.input.max_concurrent_scans = $parameters.MaxConcurrentScans

    $Request = [Request]::new($query, $operationName, $variables)

    return $Request
}

