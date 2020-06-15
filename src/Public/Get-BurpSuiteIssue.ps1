function Get-BurpSuiteIssue {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ID,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $SerialNumber,

        [Parameter(Mandatory = $false)]
        [ValidateSet('confidence', 'display_confidence', 'serial_number', 'severity', 'description_html', 'remediation_html', 'type_index', 'path',
        'origin', 'novelty', 'evidence')]
        [string[]]
        $Fields,

        [Parameter(Mandatory = $false)]
        [ValidateSet('link_url', 'link_id')]
        [string[]]
        $TicketFields,

        [Parameter(Mandatory = $false)]
        [ValidateSet('id', 'external_key', 'issue_type', 'summary', 'project', 'status', 'priority')]
        [string[]]
        $JiraTicketFields
    )

    begin {
    }

    process {

        $graphRequest = _buildIssueQuery -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
                $response
            } catch {
                throw
            }
        }
    }

    end {
    }
}
