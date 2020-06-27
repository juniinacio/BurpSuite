---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# New-BurpSuiteSite

## SYNOPSIS
Creates a new site.

## SYNTAX

```
New-BurpSuiteSite [-Name] <String> [[-ParentId] <String>] [-Scope] <PSObject>
 [-ScanConfigurationIds] <String[]> [[-EmailRecipients] <PSObject[]>] [[-ApplicationLogins] <PSObject[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new site.

## EXAMPLES

### Example 1
```powershell
PS C:\> $scope = [PSCustomObject]@{ IncludedUrls = @("http://example.com"); ExcludedUrls = @() }
PS C:\> $emailRecipient = [PSCustomObject]@{ Email = "foo@example.com" }
PS C:\> $applicationLogin = [PSCustomObject]@{ Label = "Admin"; Username = "admin"; Password = "ChangeMe" }
PS C:\> New-BurpSuiteSite -Name "www.example.com" -ParentId 0 -Scope $scope -ScanConfigurationIds '1232asdf23234f' -EmailRecipients $emailRecipient -ApplicationLogins $applicationLogin
```

This example shows how to create a new site.

## PARAMETERS

### -ApplicationLogins
Specifies one or more application login objects. An application login object is a PSCustomObject containing three properties. The first propertie is Label, this is a string that will be use as display name for the login in the BurpSuite UI. The second property is Username, this specifies the username to use for login in if needed. The last property is Password, this specifies the password to use in conjuction with the Username for authenticating to the site.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### -EmailRecipients
Specifies on or more email recipient objects. A email recipient object is a PSCustomObject containing only one property called email. The email specifies the default email to use as recipient for scan reports.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the name for the site.

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

### -ParentId
Specifies the location of the site, use 0 to create at root.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScanConfigurationIds
Specifies the default scan configuration to use for the site.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Specifies a scope object. A scope object is a PSCustomObject containing two array properties. The first propertie is called IncludedUrls, this is an array specifying the Urls to include in scans. The second property is ExcludedUrls, this is an array specifying Urls to exclude from scans, this can be omited.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

### System.Collections.Hashtable

### System.String[]

### System.Collections.Hashtable[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
