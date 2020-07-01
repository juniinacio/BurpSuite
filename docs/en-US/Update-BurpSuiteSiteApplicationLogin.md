---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Update-BurpSuiteSiteApplicationLogin

## SYNOPSIS
Updates an site application login.

## SYNTAX

### Credential (Default)
```
Update-BurpSuiteSiteApplicationLogin -Id <String> -Credential <PSCredential> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### All
```
Update-BurpSuiteSiteApplicationLogin -Id <String> -Label <String> -Credential <PSCredential> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Label
```
Update-BurpSuiteSiteApplicationLogin -Id <String> -Label <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an site application login.

## EXAMPLES

### Example 1
```powershell
PS C:\> $credentials = New-Object System.Management.Automation.PSCredential ("administrator", $(ConvertTo-SecureString "changeme" -AsPlainText -Force))
PS C:\> Update-BurpSuiteSiteApplicationLogin -Id 42 -Label "admin" -Credential $credentials
```

This example shows how to update an existing site application login.

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
Specifies the credentials of the site application login.

```yaml
Type: PSCredential
Parameter Sets: Credential, All
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Specifies the id of the site application to update.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Label
Specifies the new label of the site application login.

```yaml
Type: String
Parameter Sets: All, Label
Aliases:

Required: True
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

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
