---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Update-BurpSuiteScheduleItem

## SYNOPSIS
Updates schedule items.

## SYNTAX

```
Update-BurpSuiteScheduleItem [-Id] <String> [[-SiteId] <String>] [-ScanConfigurationIds] <String[]>
 [[-InitialRunTime] <String>] [[-RecurrenceRule] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates schedule items.

## EXAMPLES

### Example 1
```powershell
PS C:\> Update-BurpSuiteScheduleItem -Id 14 -ScanConfigurationIds b31dea7c-c03e-4f66-8f5c-083c0bc14e05
```

This example shows how to update a schedule item scan configuration.

### Example 2
```powershell
PS C:\> Update-BurpSuiteScheduleItem -Id 14 -ScanConfigurationIds b31dea7c-c03e-4f66-8f5c-083c0bc14e05 -InitialRunTime (Get-Date -Date ([DateTime]::UtcNow.AddSeconds(5)) -Format o)
```

This example shows how to update a schedule item scan configuration and initial run time.

### Example 3
```powershell
PS C:\> Update-BurpSuiteScheduleItem -Id 14 -ScanConfigurationIds b31dea7c-c03e-4f66-8f5c-083c0bc14e05 -InitialRunTime (Get-Date -Date ([DateTime]::UtcNow.AddHours(1)) -Format o) -RecurrenceRule 'FREQ=DAILY;INTERVAL=1'
```

This example shows how to update a schedule item schedule.

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

### -Id
Specifies the schedule item id.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InitialRunTime
Specifies the initial run time for the scedule.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RecurrenceRule
Specifies the recurrence rule for the schedule in RRULE format.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScanConfigurationIds
Specifies the scan configurations for the schedule.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SiteId
Specifies the site id.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

### System.String

### System.String[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
