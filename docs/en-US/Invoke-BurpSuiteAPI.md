---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Invoke-BurpSuiteAPI

## SYNOPSIS
Invokes BurpSuite GraphQL API.

## SYNTAX

### Default (Default)
```
Invoke-BurpSuiteAPI -GraphRequest <Object> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### FreeForm
```
Invoke-BurpSuiteAPI -Query <String> [-Variables <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Invokes BurpSuite GraphQL API.

## EXAMPLES

### Example 1
```powershell
PS C:\> $graphRequest = [BurpSuiteGraphRequest]::new('query GetAgents { agents { id name state enabled } }')
PS C:\> Invoke-BurpSuiteAPI -GraphRequest $graphRequest -Confirm:$false
```

This example shows how to use Invoke-BurpSuiteAPI to query BurpSuite agents.

### Example 2
```powershell
PS C:\> $graphRequest = [BurpSuiteGraphRequest]::new('query GetAgent($id:ID!) { agent(id:$id) { id name state enabled } }')
PS C:\> $graphRequest.Variables.id = 1
PS C:\> Invoke-BurpSuiteAPI -GraphRequest $graphRequest -Confirm:$false
```

This example shows how to use Invoke-BurpSuiteAPI to query a specific BurpSuite agent.

### Example 3
```powershell
PS C:\> $graphRequest = [BurpSuiteGraphRequest]::new()
PS C:\> $graphRequest.Query = 'query GetScanConfigurations { scan_configurations { id name } }'
PS C:\> Invoke-BurpSuiteAPI -GraphRequest $graphRequest -Confirm:$false
```

This example shows how to use Invoke-BurpSuiteAPI to query BurpSuite scan configurations.

### Example 4
```powershell
PS C:\> Invoke-BurpSuiteAPI -Query 'query GetAgent($id:ID!) { agent(id:$id) { id name state enabled } }' -Variables @{id = 1}
```

This example shows how to use Invoke-BurpSuiteAPI in free form mode.

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

### -GraphRequest
Specifies the request to send, use the `[BurpSuiteGraphRequest]` type accelerator to craft your desired query.

```yaml
Type: Object
Parameter Sets: Default
Aliases: Request

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Query
Specifies the query you wish to execute.

```yaml
Type: String
Parameter Sets: FreeForm
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Variables
Specifies any variables that you query needs.

```yaml
Type: Hashtable
Parameter Sets: FreeForm
Aliases:

Required: False
Position: Named
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

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
