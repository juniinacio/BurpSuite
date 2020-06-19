---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Update-BurpSuiteFalsePositive

## SYNOPSIS
Updates scan issues as false positive or not.

## SYNTAX

```
Update-BurpSuiteFalsePositive [-ScanId] <String> [-SerialNumber] <String> [-IsFalsePositive]
 [[-PropagationMode] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates scan issues as false positive or not.

## EXAMPLES

### Example 1
```powershell
PS C:\> Update-BurpSuiteFalsePositive -ScanId 1 -SerialNumber 314276827364273645 -IsFalsePositive -PropagationMode 'issue_type_only'
```

This example show how to mark a given issue as false positive.

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

### -IsFalsePositive
Specifies if the issue is false positive or not.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PropagationMode
Specifies the propagation mode.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: none, issue_type_only, issue_type_and_url

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScanId
Specifies the scan id.

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

### -SerialNumber
Specifies the serial number of the issue.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
