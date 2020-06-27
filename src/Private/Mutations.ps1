function _buildMutation {
    param([string]$queryName, [string]$inputType, [string]$name, [string]$returnType, [switch]$returnTypeField)

    $query = [Query]::New($queryName)
    $query.AddArgument('$input', $inputType)

    switch ($returnType) {
        ScanConfiguration {
            $fieldName = 'scan_configuration'
        }

        ScheduleItem {
            $fieldName = 'schedule_item'
        }

        Scan {
            $fieldName = 'scan'
        }

        Agent {
            $fieldName = 'agent'
        }

        Id {
            $fieldName = 'Id'
        }

        Folder {
            $fieldName = 'folder'
        }

        Site {
            $fieldName = 'site'
        }

        ApplicationLogin {
            $fieldName = 'application_login'
        }

        EmailRecipient {
            $fieldName = 'email_recipient'
        }

        Scope {
            $fieldName = 'scope'
        }

        default {}
    }

    if ($returnTypeField.IsPresent) {
        $mutation = _buildQueryField -name $name -objectType $returnType
        $mutation.AddArgument('input', '$input')
    } else {
        $mutation = [Query]::new($name)
        $mutation.AddArgument('input', '$input')
        $mutation.AddField((_buildQueryField -name $fieldName -objectType $returnType))
    }

    $query.AddField($mutation)

    return ('mutation {0}' -f $query)
}

