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

        $query = _buildMutation -queryName 'UpdateSiteScopeV2' -inputType 'UpdateSiteScopeV2Input!' -name 'update_site_scope_v2' -returnType 'Site'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{ scope_v2 = @{} } }
                $variables.input.site_id = $SiteId

                $variables.input.scope_v2.start_urls = $StartUrls

                if ($PSBoundParameters.ContainsKey('InScopeUrlPrefixes')) { $variables.input.scope_v2.in_scope_url_prefixes = $InScopeUrlPrefixes }
                else { $variables.input.scope_v2.in_scope_url_prefixes = @() }

                if ($PSBoundParameters.ContainsKey('OutOfScopeUrlPrefixes')) { $variables.input.scope_v2.out_of_scope_url_prefixes = $OutOfScopeUrlPrefixes }
                else { $variables.input.scope_v2.out_of_scope_url_prefixes = @() }

                if ($PSBoundParameters.ContainsKey('ProtocolOptions')) { $variables.input.scope_v2.protocol_options = $ProtocolOptions }
                else { $variables.input.scope_v2.protocol_options = 'USE_HTTP_AND_HTTPS' }

                $request = [Request]::new($query, 'UpdateSiteScopeV2', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
