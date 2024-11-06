---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Update-BurpSuiteSiteScope

## SYNOPSIS
Updates site scopes.

## SYNTAX

```
Update-BurpSuiteSiteScope [-SiteId] <String> [-StartUrls] <String[]> [[-InScopeUrlPrefixes] <String[]>]
 [[-OutOfScopeUrlPrefixes] <String[]>] [[-ProtocolOptions] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates site scopes.

## EXAMPLES

### Example 1
```powershell
PS C:\> Update-BurpSuiteSiteScope -SiteId 42 -StartUrls "http://example.com" -OutOfScopeUrlPrefixes "http://example.com/foo"
```

This example shows how to update a site scope.

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

### -InScopeUrlPrefixes
Specifies a list of URLs that Burp Scanner is allowed to scan. If the list is empty, the site scope is automatically derived from the start URLs.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OutOfScopeUrlPrefixes
Specifies a list of URLs that will be skipped during scans of this site. For example, if a particular subdirectory contains sensitive data, you can enter its URL here to exclude it from scans. All subdirectories of an excluded URL will also be skipped.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProtocolOptions
Specifies options to determine which protocols are used when scanning your site's URLs. Can be one of 'USE_SPECIFIED_PROTOCOLS' or 'USE_HTTP_AND_HTTPS'

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: USE_SPECIFIED_PROTOCOLS, USE_HTTP_AND_HTTPS

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SiteId
Specifies the id of the site to update.

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

### -StartUrls
Specifies the URLs that Burp Scanner begins the scan from.

```yaml
Type: String[]
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

### System.String[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
