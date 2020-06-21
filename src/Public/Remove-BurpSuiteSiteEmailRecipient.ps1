function Remove-BurpSuiteSiteEmailRecipient {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'DeleteSiteEmailRecipient' -inputType 'DeleteSiteEmailRecipientInput!' -name 'delete_site_email_recipient' -returnType 'Id' -returnTypeField

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id

                $request = [Request]::new($query, 'DeleteSiteEmailRecipient', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
