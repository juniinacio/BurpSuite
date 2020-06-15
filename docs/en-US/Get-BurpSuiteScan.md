---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Get-BurpSuiteScan

## SYNOPSIS
Gets BurpSuite scans.

## SYNTAX

### Specific (Default)
```
Get-BurpSuiteScan -ID <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### List
```
Get-BurpSuiteScan -Offset <Int32> -Limit <Int32> -SortColumn <String> -SortOrder <String> -ScanStatus <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets BurpSuite scans.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BurpSuiteScan -ID 1
```

This example shows how to get the scan with ID 1.

### Example 2
```powershell
PS C:\> Get-BurpSuiteScan -Offset 1 -Limit 10 -SortColumn 'start' -SortOrder 'asc' -ScanStatus 'queued'
```

This example shows how to get a list of scans starting at offset 1.

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

### -ID
Specifies the ID of the scan to retrieve.

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

### -Limit
Specifies the limit of items to return.

```yaml
Type: Int32
Parameter Sets: List
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Offset
Specifies the offset for start listing scans.

```yaml
Type: Int32
Parameter Sets: List
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanStatus
Specifies wich type of scans to retrieve.

```yaml
Type: String
Parameter Sets: List
Aliases:
Accepted values: queued, running, succeeded, cancelled, failed

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortColumn
Specifies the sorting column.

```yaml
Type: String
Parameter Sets: List
Aliases:
Accepted values: start, end, status, site, id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortOrder
Specifies the sorting order.

```yaml
Type: String
Parameter Sets: List
Aliases:
Accepted values: asc, desc

Required: True
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
