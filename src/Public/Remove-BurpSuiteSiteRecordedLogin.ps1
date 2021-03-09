function Remove-BurpSuiteSiteRecordedLogin {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'DeleteSiteRecordedLogin' -inputType 'DeleteSiteRecordedLoginInput!' -name 'delete_site_recorded_login' -returnType 'Id' -returnTypeField

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.id = $Id

                $request = [Request]::new($query, 'DeleteSiteRecordedLogin', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
