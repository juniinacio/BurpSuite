InModuleScope $env:BHProjectName {
    Context "Specific" {
        Describe "Get-BurpSuiteSiteTree" {
            It "should get site tree" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteSiteTree

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.OperationName -eq "GetSiteTree" `
                        -and $GraphRequest.Query -like 'query GetSiteTree { site_tree { * } }'
                }
            }

            It "should add <FieldName> sub query field" -TestCases @(
                @{ FieldName = "folders"; Query = "folders { id name parent_id }" }
                @{ FieldName = "sites"; Query = "sites { id name parent_id scope { included_urls excluded_urls } scan_configurations { id name } application_logins { id label username } ephemeral email_recipients { id email } }" }
            ) {
                # arrange
                Mock -CommandName _callAPI

                # act
                Get-BurpSuiteSiteTree -Fields $FieldName

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.Query -like "query GetSiteTree { site_tree { *$Query* } }"
                }
            }
        }
    }
}
