InModuleScope $env:BHProjectName {
    Describe "Invoke-BurpSuiteAPI" {
        Context "Default" {
            It "should invoke BurpSuite Graph API" {
                # arrange
                $Request = [Request]::new('{ __schema { queryType { name } } }')

                Mock -CommandName _callAPI

                # act
                Invoke-BurpSuiteAPI -Request $Request -Confirm:$false

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $Request.query -eq "{ __schema { queryType { name } } }"
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
                    $Request.query -eq "{ __schema { queryType { name } } }"
                }
            }

            It "should add variables" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Invoke-BurpSuiteAPI -Query 'query GetAgent($id:ID!) { agent(id:$id) { id name state enabled } }' -Variables @{ id = 12345 } -Confirm:$false

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $Request.Query -eq 'query GetAgent($id:ID!) { agent(id:$id) { id name state enabled } }' `
                        -and $Request.Variables.id -eq 12345
                }
            }
        }
    }
}
