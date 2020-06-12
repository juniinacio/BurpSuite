InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteAgent" {
        It "should get agents" {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteAgent

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetAgents" `
                    -and $GraphRequest.Query -eq "query GetAgents { agent { id name state enabled } }"
            }
        }

        It "should set agent fields" {
            # arrange
            $fields = 'id', 'machine_id', 'current_scan_count', 'ip', 'name', 'state', 'enabled', 'max_concurrent_scans'

            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteAgent -Fields $fields

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetAgents" `
                    -and $GraphRequest.Query -eq "query GetAgents { agent { $($fields -join ' ') } }"
            }
        }

        It "should set agent error fields" {
            # arrange
            $fields = 'code', 'error'

            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteAgent -ErrorFields $fields

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetAgents" `
                    -and $GraphRequest.Query -eq "query GetAgents { agent { id name state enabled error { $($fields -join ' ') } } }"
            }
        }

        It "should get agent by ID" {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteAgent -ID 12345

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetAgent" `
                    -and $GraphRequest.Query -eq 'query GetAgent($id:"ID!") { agent(id:"$id") { id name state enabled } }'
            }
        }
    }
}
