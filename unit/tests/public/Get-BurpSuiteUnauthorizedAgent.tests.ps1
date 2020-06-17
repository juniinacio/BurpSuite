InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteUnauthorizedAgent" {
        It "should get unauthorized agents" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        unauthorized_agents = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteUnauthorizedAgent

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetUnauthorizedAgents" `
                    -and $GraphRequest.Query -eq "query GetUnauthorizedAgents { unauthorized_agents { ip } }"
            }
        }

        It "should set unauthorized agent selection fields" {
            # arrange
            $fields = 'machine_id', 'ip'

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        unauthorized_agents = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

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
