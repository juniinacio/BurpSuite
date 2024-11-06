function Update-BurpSuiteSiteScope {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $SiteId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]] $StartUrls,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [AllowEmptyCollection()]
        [string[]] $InScopeUrlPrefixes,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [AllowEmptyCollection()]
        [string[]] $OutOfScopeUrlPrefixes,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("USE_SPECIFIED_PROTOCOLS", "USE_HTTP_AND_HTTPS")]
        [string] $ProtocolOptions
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'UpdateSiteScope' -inputType 'UpdateSiteScopeInput!' -name 'update_site_scope' -returnType 'ScopeV2'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.site_id = $SiteId

                $variables.input.start_urls = $StartUrls

                if ($PSBoundParameters.ContainsKey('InScopeUrlPrefixes')) { $variables.input.in_scope_url_prefixes = $InScopeUrlPrefixes }
                else { $variables.input.in_scope_url_prefixes = @() }

                if ($PSBoundParameters.ContainsKey('OutOfScopeUrlPrefixes')) { $variables.input.out_of_scope_url_prefixes = $OutOfScopeUrlPrefixes }
                else { $variables.input.out_of_scope_url_prefixes = @() }

                if ($PSBoundParameters.ContainsKey('ProtocolOptions')) { $variables.input.protocol_options = $ProtocolOptions }
                else { $variables.input.protocol_options = 'USE_HTTP_AND_HTTPS' }

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
