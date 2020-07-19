function _buildMutation {
    param([string]$queryName, [string]$inputType, [string]$name, [string]$returnType, [switch]$returnTypeField)

    $query = [Query]::New($queryName)

    $query.AddArgument('$input', $inputType)

    switch ($returnType) {
        ScanConfiguration { $fieldName = 'scan_configuration' }
        ScheduleItem { $fieldName = 'schedule_item' }
        Scan { $fieldName = 'scan' }
        Agent { $fieldName = 'agent' }
        Id { $fieldName = 'Id' }
        Folder { $fieldName = 'folder' }
        Site { $fieldName = 'site' }
        ApplicationLogin { $fieldName = 'application_login' }
        EmailRecipient { $fieldName = 'email_recipient' }
        Scope { $fieldName = 'scope' }
        default {}
    }

    if ($returnTypeField.IsPresent) {
        $subQuery = _buildField -name $name -objectType $returnType
        $subQuery.AddArgument('input', '$input')
    } else {
        $subQuery = [Query]::new($name)
        $subQuery.AddArgument('input', '$input')
        $subQuery.AddField((_buildField -name $fieldName -objectType $returnType))
    }

    $query.AddField($subQuery)

    return ('mutation {0}' -f $query)
}

