function Update-BurpSuiteSiteScope {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $SiteId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]] $IncludedUrls,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [AllowEmptyCollection()]
        [string[]] $ExcludedUrls
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'UpdateSiteScope' -inputType 'UpdateSiteScopeInput!' -name 'update_site_scope' -returnType 'Scope'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.site_id = $SiteId

                $variables.input.included_urls = $IncludedUrls

                if ($PSBoundParameters.ContainsKey('ExcludedUrls')) { $variables.input.excluded_urls = $ExcludedUrls }
                else { $variables.input.excluded_urls = @() }

                $request = [Request]::new($query, 'UpdateSiteScope', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
