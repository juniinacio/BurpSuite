function New-BurpSuiteSiteEmailRecipient {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $SiteId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $EmailRecipient
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'CreateSiteEmailRecipient' -inputType 'CreateSiteEmailRecipientInput!' -name 'create_site_email_recipient' -returnType 'EmailRecipient'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.site_id = $SiteId
                $variables.input.email_recipient = @{email = $EmailRecipient }

                $request = [Request]::new($query, 'CreateSiteEmailRecipient', $variables)

                $response = _callAPI -Request $request
                $response.data.create_site_email_recipient.email_recipient
            } catch {
                throw
            }
        }
    }

    end {
    }
}
