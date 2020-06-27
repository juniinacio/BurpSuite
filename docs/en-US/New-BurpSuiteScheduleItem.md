---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# New-BurpSuiteScheduleItem

## SYNOPSIS
Creates schedule items.

## SYNTAX

```
New-BurpSuiteScheduleItem [-SiteId] <String> [-ScanConfigurationIds] <String[]> [[-Schedule] <PSObject>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates schedule items.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-BurpSuiteScheduleItem -SiteId 14 -ScanConfigurationIds b31dea7c-c03e-4f66-8f5c-083c0bc14e05
```

This example shows how to create a schedule item to scan a site with id 14. The scan will start as soon as a agent is available.

### Example 2
```powershell
PS C:\> $schedule = [PSCustomObject]@{ InitialRunTime = (Get-Date -Date ([DateTime]::UtcNow.AddSeconds(5)) -Format o) }
PS C:\> New-BurpSuiteScheduleItem -SiteId 14 -ScanConfigurationIds b31dea7c-c03e-4f66-8f5c-083c0bc14e05 -Schedule $schedule
```

This example shows how to create a schedule item to start a scan over 5 seconds.

### Example 3
```powershell
PS C:\> $schedule = [PSCustomObject]@{ InitialRunTime = (Get-Date -Date ([DateTime]::UtcNow.AddSeconds(5)) -Format o); RRule = 'FREQ=DAILY;INTERVAL=1' }
PS C:\> New-BurpSuiteScheduleItem -SiteId 14 -ScanConfigurationIds b31dea7c-c03e-4f66-8f5c-083c0bc14e05 -Schedule $schedule
```

This example shows how to create a schedule item to start a scan over 1 hour and repeat every day.

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

### -ScanConfigurationIds
Specifies the scan configurations for the schedule.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Schedule
Specifies a schedule item input. Supply a PSCustomObject containing the following properties: `InitialRunTime`, `RRule`.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
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

Required: True
Position: 0
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
