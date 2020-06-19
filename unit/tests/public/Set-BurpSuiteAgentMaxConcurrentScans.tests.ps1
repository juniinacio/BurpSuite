InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteAgentMaxConcurrentScans" {
        It "should get agents" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_agent_max_concurrent_scans = [PSCustomObject]@{
                            agent = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            Set-BurpSuiteAgentMaxConcurrentScans -Id 1 -MaxConcurrentScans 10

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "UpdateAgentMaxConcurrentScans" `
                    -and $GraphRequest.Query -eq 'mutation UpdateAgentMaxConcurrentScans($input:UpdateAgentMaxConcurrentScansInput!) { update_agent_max_concurrent_scans(input:$input) { agent { id name max_concurrent_scans enabled } } }' `
                    -and $GraphRequest.Variables.input.id -eq 1 `
                    -and $GraphRequest.Variables.input.max_concurrent_scans -eq 10
            }
        }
    }
}
