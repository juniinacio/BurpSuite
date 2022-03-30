InModuleScope $env:BHProjectName {
    Describe "Move-BurpSuiteSite" {
        It "should move site" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        move_site = [PSCustomObject]@{
                            site = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            Move-BurpSuiteSite -SiteId 42 -ParentId 2

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "MoveSite" `
                    -and $Request.Query -eq 'mutation MoveSite($input:MoveSiteInput!) { move_site(input:$input) { site { id name parent_id scope { included_urls excluded_urls } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } } } }' `
                    -and $Request.Variables.Input.site_id -eq 42 `
                    -and $Request.Variables.Input.parent_id -eq 2
            }
        }
    }
}
