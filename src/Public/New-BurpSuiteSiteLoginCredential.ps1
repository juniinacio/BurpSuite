function New-BurpSuiteSiteLoginCredential {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $SiteId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Label,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.CredentialAttribute()]
        $Credential
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'CreateSiteLoginCredential' -inputType 'CreateSiteLoginCredentialInput!' -name 'create_site_login_credential' -returnType 'LoginCredential'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $networkCredential = $Credential.GetNetworkCredential()

                $variables = @{ input = @{} }
                $variables.input.site_id = $SiteId
                $variables.input.login_credential = @{}
                $variables.input.login_credential.label = $Label
                $variables.input.login_credential.username = $networkCredential.UserName
                $variables.input.login_credential.password = $networkCredential.Password

                $request = [Request]::new($query, 'CreateSiteLoginCredential', $variables)

                $response = _callAPI -Request $request
                $response.data.create_site_login_credential.login_credential
            } catch {
                throw
            }
        }
    }

    end {
    }
}
