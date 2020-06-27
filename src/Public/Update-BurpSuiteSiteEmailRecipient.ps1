function Update-BurpSuiteSiteEmailRecipient {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Email
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'UpdateSiteEmailRecipient' -inputType 'UpdateSiteEmailRecipientInput!' -name 'update_site_email_recipient' -returnType 'EmailRecipient'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id
                $variables.input.email = $Email

                $request = [Request]::new($query, 'UpdateSiteEmailRecipient', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
