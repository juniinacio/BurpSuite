---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Get-BurpSuiteScanReport

## SYNOPSIS
Gets a scan report.

## SYNTAX

### Download (Default)
```
Get-BurpSuiteScanReport -ScanId <String> [-TimezoneOffset <Int32>] [-ReportType <String>]
 [-IncludeFalsePositives] [-Severities <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DownloadToDisk
```
Get-BurpSuiteScanReport -ScanId <String> [-TimezoneOffset <Int32>] [-ReportType <String>]
 [-IncludeFalsePositives] [-Severities <String[]>] -OutFile <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets a scan report.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BurpSuiteScanReport -ID 1
```

This example shows how to retrieve the scan report with ID 1.

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

### -IncludeFalsePositives
Specifies if the report should contain false positives.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
Specifies the path to save the report.

```yaml
Type: String
Parameter Sets: DownloadToDisk
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReportType
Specifies the type of report you wish to fetch.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: detailed, summary

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanId
Specifies the scan id to download the report.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Severities
Specifies the types of severities to include.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: info, low, medium, high

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimezoneOffset
Specifies the time zone offset.

```yaml
Type: Int32
Parameter Sets: (All)
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
