function Update-BurpSuiteSiteApplicationLogin {
    [CmdletBinding(DefaultParameterSetName = 'Credential', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Label')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'All')]
        [ValidateNotNullOrEmpty()]
        [string] $Label,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Credential')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'All')]
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
                $variables = @{ input = @{} }
                $variables.input.id = $Id

                if ($PSBoundParameters.ContainsKey('Label')) {
                    $variables.input.label = $Label
                }

                if ($PSBoundParameters.ContainsKey('Credential')) {
                    $networkCredential = $Credential.GetNetworkCredential()
                    $variables.input.username = $networkCredential.UserName
                    $variables.input.password = $networkCredential.Password
                }

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
