InModuleScope $env:BHProjectName {
    Describe "Update-BurpSuiteSiteScope" {
        It "should update site scop" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_site_scope = [PSCustomObject]@{
                            site = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            Update-BurpSuiteSiteScope -SiteId 42 -StartUrls "http://example.com" -InScopeUrlPrefixes "http://example.com/foo" -OutOfScopeUrlPrefixes "http://example.com/admin" -ProtocolOptions "USE_HTTP_AND_HTTPS"

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateSiteScope" `
                    -and $Request.Query -eq 'mutation UpdateSiteScope($input:UpdateSiteScopeInput!) { update_site_scope(input:$input) { scope_v2 { start_urls in_scope_url_prefixes out_of_scope_url_prefixes protocol_options } } }' `
                    -and $Request.Variables.Input.site_id -eq 42 `
                    # -and $Request.Variables.Input.start_urls[0] -eq "http://example.com" `
                    # -and $Request.Variables.Input.in_scope_url_prefixes[0] -eq "http://example.com/foo" `
                    # -and $Request.Variables.Input.out_of_scope_url_prefixes[0] -eq "http://example.com/admin" `
                    # -and $Request.Variables.Input.protocol_options -eq "USE_HTTP_AND_HTTPS"
            }
        }
    }
}
