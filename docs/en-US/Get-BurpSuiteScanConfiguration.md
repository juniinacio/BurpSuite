---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Get-BurpSuiteScanConfiguration

## SYNOPSIS
Gets BurpSuite scan configurations.

## SYNTAX

```
Get-BurpSuiteScanConfiguration [[-Fields] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets BurpSuite scan configurations.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BurpSuiteScanConfiguration
```

The above example shows how to list all scan configurations.

### Example 2
```powershell
PS C:\> Get-BurpSuiteScanConfiguration -Fields 'id', 'name', 'scan_configuration_fragment_json'
```

The above example shows how to get scan configurations and also how to request more fields.

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

### -Fields
Specifies the scan configuration fields to retrieve, by default the cmdlet only retrieves the 'id', 'name' properties of scan configurations.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: id, name, scan_configuration_fragment_json, built_in, last_modified_time, last_modified_by

Required: False
Position: 0
Default value: None
Accept pipeline input: False
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
