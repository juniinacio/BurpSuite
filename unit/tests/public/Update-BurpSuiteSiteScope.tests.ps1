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
                $Request.OperationName -eq "UpdateSiteScopeV2" `
                    -and $Request.Query -eq 'mutation UpdateSiteScopeV2($input:UpdateSiteScopeV2Input!) { update_site_scope_v2(input:$input) { site { id name parent_id scope_v2 { start_urls in_scope_url_prefixes out_of_scope_url_prefixes protocol_options } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } } } }' `
                    -and $Request.Variables.Input.site_id -eq 42 `
                    -and $Request.Variables.Input.scope_v2.start_urls[0] -eq "http://example.com" `
                    -and $Request.Variables.Input.scope_v2.in_scope_url_prefixes[0] -eq "http://example.com/foo" `
                    -and $Request.Variables.Input.scope_v2.out_of_scope_url_prefixes[0] -eq "http://example.com/admin" `
                    -and $Request.Variables.Input.scope_v2.protocol_options -eq "USE_HTTP_AND_HTTPS"
            }
        }
    }
}
