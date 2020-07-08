---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Grant-BurpSuiteAgent

## SYNOPSIS
Authorizes agents

## SYNTAX

```
Grant-BurpSuiteAgent [-MachineId] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Authorizes agents

## EXAMPLES

### Example 1
```powershell
PS C:\> Grant-BurpSuiteAgent -MachineId '313d80669b7918a2c22e8ffdeff607bc28879fdae50c1c2bb620147e72c473d7'
```

This example show how to authorize an agent.

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

### -MachineId
Specifies the machine id of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: machine_id

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

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
