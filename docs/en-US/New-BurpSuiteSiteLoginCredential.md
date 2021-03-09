---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# New-BurpSuiteSiteLoginCredential

## SYNOPSIS
Creates an site application login.

## SYNTAX

```
New-BurpSuiteSiteLoginCredential [-SiteId] <String> [-Label] <String> [-Credential] <PSCredential> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an site application login.

## EXAMPLES

### Example 1
```powershell
PS C:\> $credentials = New-Object System.Management.Automation.PSCredential ("administrator", $(ConvertTo-SecureString "changeme" -AsPlainText -Force))
PS C:\> New-BurpSuiteSiteApplicationLogin -SiteId 1 -Label "admin" -Credential $credentials
```

This example shows how to create a new site application login.

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

### -Credential
Specifies the credential for the login.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Label
Specifies the label for the login.

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

### -SiteId
Specifies the site where the login is used.

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

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
