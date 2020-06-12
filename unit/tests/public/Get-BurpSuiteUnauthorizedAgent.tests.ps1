InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteUnauthorizedAgent" {
        It "should get unauthorized agents" {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteUnauthorizedAgent

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetUnauthorizedAgents" `
                    -and $GraphRequest.Query -eq "query GetUnauthorizedAgents { unauthorized_agents { ip } }"
            }
        }

        It "should set unauthorized agent fields" {
            # arrange
            $fields = 'machine_id', 'ip'

            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteUnauthorizedAgent -Fields $fields

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetUnauthorizedAgents" `
                    -and $GraphRequest.Query -eq "query GetUnauthorizedAgents { unauthorized_agents { $($fields -join ' ') } }"
            }
        }
    }
}
