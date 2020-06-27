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
            Update-BurpSuiteSiteScope -SiteId 42 -IncludedUrls "http://example.com" -ExcludedUrls "http://example.com/foo"

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateSiteScope" `
                    -and $Request.Query -eq 'mutation UpdateSiteScope($input:''UpdateSiteScopeInput!'') { update_site_scope(input:''$input'') { scope { included_urls excluded_urls } } }' `
                    -and $Request.Variables.Input.site_id -eq 42 `
                    -and $Request.Variables.Input.included_urls[0] -eq "http://example.com" `
                    -and $Request.Variables.Input.excluded_urls[0] -eq "http://example.com/foo"
            }
        }
    }
}
