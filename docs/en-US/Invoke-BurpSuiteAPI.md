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

```
Invoke-BurpSuiteAPI [-GraphRequest] <GraphRequest> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Invokes BurpSuite GraphQL API.

## EXAMPLES

### Example 1
```powershell
PS C:\> $graphRequest = [GraphRequest]::new('query GetAgents { agents { id name state enabled } }')
PS C:\> Invoke-BurpSuiteAPI -GraphRequest $graphRequest -Confirm:$false
```

This example shows how to use Invoke-BurpSuiteAPI to query BurpSuite agents.

### Example 2
```powershell
PS C:\> $graphRequest = [GraphRequest]::new('query GetAgent($id:ID!) { agent(id:$id) { id name state enabled } }')
PS C:\> $graphRequest.Variables.id = 1
PS C:\> Invoke-BurpSuiteAPI -GraphRequest $graphRequest -Confirm:$false
```

This example shows how to use Invoke-BurpSuiteAPI to query a specific BurpSuite agent.

### Example 3
```powershell
PS C:\> $graphRequest = [GraphRequest]::new()
PS C:\> $graphRequest.Query = 'query GetScanConfigurations { scan_configurations { id name } }'
PS C:\> Invoke-BurpSuiteAPI -GraphRequest $graphRequest -Confirm:$false
```

This example shows how to use Invoke-BurpSuiteAPI to query BurpSuite scan configurations.

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
Specifies the request to send, use the `[GraphRequest]` type accelerator to craft your desired query.

```yaml
Type: GraphRequest
Parameter Sets: (All)
Aliases: Request

Required: True
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
