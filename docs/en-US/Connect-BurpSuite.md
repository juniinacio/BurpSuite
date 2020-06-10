---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Connect-BurpSuite

## SYNOPSIS
Connects BurpSuite to your BurpSuite Enterprise server.

## SYNTAX

```
Connect-BurpSuite [-ApiKey] <String> [-Uri] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Connects BurpSuite to your BurpSuite Enterprise server.

## EXAMPLES

### EXAMPLE 1
```
PS /> Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"
```

This example shows how to connect the module to a BurpSuite Enterprise.

## PARAMETERS

### -ApiKey
Specifies the API key to use for accessing your BurpSuite Enterprise server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -Uri
Specifies the URL to your BurpSuite Enterprise server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### Inputs to this cmdlet (if any)
## OUTPUTS

### Output from this cmdlet (if any)
## NOTES
General notes

## RELATED LINKS
