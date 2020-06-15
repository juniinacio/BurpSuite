---
external help file: BurpSuite-help.xml
Module Name: BurpSuite
online version:
schema: 2.0.0
---

# Get-BurpSuiteIssue

## SYNOPSIS
Gets BurpSuite issues.

## SYNTAX

```
Get-BurpSuiteIssue [-ID] <String> [-SerialNumber] <String> [[-Fields] <String[]>] [[-TicketFields] <String[]>]
 [[-JiraTicketFields] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets BurpSuite issues.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BurpSuiteIssue -ID 1 -SerialNumber 314276827364273645
```

This example shows how to retrieve an issue.

### Example 2
```powershell
PS C:\> Get-BurpSuiteIssue -ID 1 -SerialNumber 314276827364273645 -Fields 'confidence', 'display_confidence', 'serial_number'
```

This example shows how to retrieve an issue with certain fields.

### Example 3
```powershell
PS C:\> Get-BurpSuiteIssue -ID 1 -SerialNumber 314276827364273645 -TicketFields 'link_url', 'link_id'
```

This example shows how to retrieve an issue with ticket fields.

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
Specifies the issue fields to retrieve for the issue.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: confidence, display_confidence, serial_number, severity, description_html, remediation_html, type_index, path, origin, novelty, evidence

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
Specifies the ID for the issue to retrieve.

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

### -JiraTicketFields
Specifies the witch Jira ticket fields to retrieve for the issue.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: id, external_key, issue_type, summary, project, status, priority

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SerialNumber
Specifies the serial number for the issue to retrieve.

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

### -TicketFields
Specifies the witch ticket fields to retrieve for the issue.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: link_url, link_id

Required: False
Position: 3
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
