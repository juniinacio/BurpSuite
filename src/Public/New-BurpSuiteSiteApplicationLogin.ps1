function New-BurpSuiteSiteApplicationLogin {
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

        $query = _buildMutation -queryName 'CreateSiteApplicationLogin' -inputType 'CreateSiteApplicationLoginInput!' -name 'create_site_application_login' -returnType 'ApplicationLogin'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $networkCredential = $Credential.GetNetworkCredential()

                $variables = @{ input = @{} }
                $variables.input.site_id = $SiteId
                $variables.input.application_login = @{}
                $variables.input.application_login.label = $Label
                $variables.input.application_login.username = $networkCredential.UserName
                $variables.input.application_login.password = $networkCredential.Password

                $request = [Request]::new($query, 'CreateSiteApplicationLogin', $variables)

                $response = _callAPI -Request $request
                $response.data.create_site_application_login.application_login
            } catch {
                throw
            }
        }
    }

    end {
    }
}
