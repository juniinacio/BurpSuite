function New-BurpSuiteSiteRecordedLogin {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $SiteId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Label,

        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf })]
        [string]
        $FilePath
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'CreateSiteRecordedLogin' -inputType 'CreateSiteRecordedLoginInput!' -name 'create_site_recorded_login' -returnType 'RecordedLogin'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.site_id = $SiteId
                $variables.input.recorded_login = @{}
                $variables.input.recorded_login.label = $Label
                $variables.input.recorded_login.script = Get-Content -Raw -Path $FilePath | Out-String

                $request = [Request]::new($query, 'CreateSiteRecordedLogin', $variables)

                $response = _callAPI -Request $request
                $response.data.create_site_recorded_login.recorded_login
            } catch {
                throw
            }
        }
    }

    end {
    }
}
