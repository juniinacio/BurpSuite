---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Get-BurpSuiteScheduleItem

## SYNOPSIS
Gets a schedule item.

## SYNTAX

### List (Default)
```
Get-BurpSuiteScheduleItem [-SortBy <String>] [-SortOrder <String>] [-Fields <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Specific
```
Get-BurpSuiteScheduleItem -ID <String> [-Fields <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets a schedule item.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BurpSuiteScheduleItem -ID 1
```

This example shows how to retrieve the schedule with ID 1.

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
Specifies the report fields to retrieve.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: id, site, schedule, scan_configurations, has_run_more_than_once, scheduled_run_time

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
Specifies the report ID to retrieve.

```yaml
Type: String
Parameter Sets: Specific
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Specifies the reports sorting column (the API isn't clear about this field)?

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortOrder
Specifies the reports sorting order (the API isn't clear about this field)?

```yaml
Type: String
Parameter Sets: List
Aliases:

Required: False
Position: Named
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
