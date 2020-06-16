---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Get-BurpSuiteAgent

## SYNOPSIS
Gets BurpSuite agents.

## SYNTAX

```
Get-BurpSuiteAgent [[-Fields] <String[]>] [[-ID] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets BurpSuite agents.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BurpSuiteAgent
```

This example shows how to retrieve all agents.

### Example 2
```powershell
PS C:\> Get-BurpSuiteAgent -ID 1
```

This example shows how to retrieve an agent by id.

### Example 3
```powershell
PS C:\> Get-BurpSuiteAgent -ID 1 -Fields 'id', 'machine_id', 'current_scan_count', 'ip', 'name', 'state', 'error', 'enabled', 'max_concurrent_scans'
```

This example shows how to retrieve an agent by id together with fields.

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
Specifies the agents fields to retrieve.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: id, machine_id, current_scan_count, ip, name, state, error, enabled, max_concurrent_scans

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
Specifies the ID of the agent to retrieve.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
