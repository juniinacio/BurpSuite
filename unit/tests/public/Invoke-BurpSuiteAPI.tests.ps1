InModuleScope $env:BHProjectName {
    Describe "Invoke-BurpSuiteAPI" {
        Context "Default" {
            It "should invoke BurpSuite Graph API" {
                # arrange
                $graphRequest = [GraphRequest]::new('{ __schema { queryType { name } } }')

                Mock -CommandName _callAPI

                # act
                Invoke-BurpSuiteAPI -GraphRequest $graphRequest -Confirm:$false

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.query -eq "{ __schema { queryType { name } } }"
                }
            }
        }

        Context "FreeForm" {
            It "should invoke BurpSuite Graph API" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Invoke-BurpSuiteAPI -Query '{ __schema { queryType { name } } }' -Confirm:$false

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.query -eq "{ __schema { queryType { name } } }"
                }
            }

            It "should add variables" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Invoke-BurpSuiteAPI -Query 'query GetAgent($id:ID!) { agent(id:$id) { id name state enabled } }' -Variables @{ id = 12345 } -Confirm:$false

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.Query -eq 'query GetAgent($id:ID!) { agent(id:$id) { id name state enabled } }' `
                        -and $GraphRequest.Variables.id -eq 12345
                }
            }
        }
    }
}
