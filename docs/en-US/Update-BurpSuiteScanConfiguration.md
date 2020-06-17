---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Update-BurpSuiteScanConfiguration

## SYNOPSIS
Updates scan configurations.

## SYNTAX

### UpdateName (Default)
```
Update-BurpSuiteScanConfiguration -Id <String> -Name <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### AllFields
```
Update-BurpSuiteScanConfiguration -Id <String> -Name <String> -FilePath <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### UpdateSettings
```
Update-BurpSuiteScanConfiguration -Id <String> -FilePath <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates scan configurations.

## EXAMPLES

### Example 1
```powershell
PS C:\> Update-BurpSuiteScanConfiguration -Id f2dd34b4-6aa3-488b-bd72-ade596bed0a7 -FilePath .\unit\tests\mocks\scan_configuration.json
```

This example show how to update a scan configuration configuration.

### Example 2
```powershell
PS C:\> Update-BurpSuiteScanConfiguration -Id f2dd34b4-6aa3-488b-bd72-ade596bed0a7 -Name 'Crawl strategy - custom'
```

This example show how to update a scan configuration name.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Specifies the path to the scan configuration fragment json file.

```yaml
Type: String
Parameter Sets: AllFields, UpdateSettings
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Specifies the id for the scan configuration you wish to update.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the new name for the scan configuration.

```yaml
Type: String
Parameter Sets: UpdateName, AllFields
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
