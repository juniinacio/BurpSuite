---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Get-BurpSuiteUnauthorizedAgent

## SYNOPSIS
Gets BurpSuite unauthorized agents.

## SYNTAX

```
Get-BurpSuiteUnauthorizedAgent [[-Fields] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets BurpSuite unauthorized agents.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BurpSuiteUnauthorizedAgent
```

This example shows how to retrieve unauthorized agents.

### Example 2
```powershell
PS C:\> Get-BurpSuiteUnauthorizedAgent -Fields 'machine_id', 'ip'
```

This example shows how to retrieve unauthorized agents together with specific fields.

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
Specifies the fields to retrieve.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: machine_id, ip

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
