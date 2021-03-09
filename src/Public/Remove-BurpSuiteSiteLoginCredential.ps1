function Remove-BurpSuiteSiteLoginCredential {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    [Alias('Remove-BurpSuiteSiteApplicationLogin')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'DeleteSiteLoginCredential' -inputType 'DeleteSiteLoginCredentialInput!' -name 'delete_site_login_credential' -returnType 'Id' -returnTypeField

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id

                $request = [Request]::new($query, 'DeleteSiteLoginCredential', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
