function Update-BurpSuiteSiteApplicationLogin {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

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

        $query = _buildMutation -queryName 'UpdateSiteApplicationLogin' -inputType 'UpdateSiteApplicationLoginInput!' -name 'update_site_application_login' -returnType 'ApplicationLogin'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $networkCredential = $Credential.GetNetworkCredential()

                $variables = @{ input = @{} }
                $variables.input.id = $Id
                $variables.input.label = $Label
                $variables.input.username = $networkCredential.UserName
                $variables.input.password = $networkCredential.Password

                $request = [Request]::new($query, 'UpdateSiteApplicationLogin', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
