InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteSiteTree" {
        It "should get site tree" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        site_tree = [PSCustomObject]@{
                            folders = @()
                            sites   = @()
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteSiteTree

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like 'query { site_tree { * } }'
            }
        }

        It "should add <FieldName> sub selection field" -TestCases @(
            @{ FieldName = "folders"; Query = "folders { id name parent_id }" }
            @{ FieldName = "sites"; Query = "sites { id name parent_id scope_v2 { start_urls in_scope_url_prefixes out_of_scope_url_prefixes protocol_options } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } }" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        site_tree = [PSCustomObject]@{
                            folders = @()
                            sites   = @()
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteSiteTree -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { site_tree { *$Query* } }"
            }
        }
    }
}
