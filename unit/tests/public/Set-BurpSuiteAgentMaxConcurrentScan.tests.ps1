InModuleScope $env:BHProjectName {
    Describe "Set-BurpSuiteAgentMaxConcurrentScan" {
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
            Set-BurpSuiteAgentMaxConcurrentScan -Id 1 -MaxConcurrentScans 10

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateAgentMaxConcurrentScans" `
                    -and $Request.Query -eq 'mutation UpdateAgentMaxConcurrentScans($input:''UpdateAgentMaxConcurrentScansInput!'') { update_agent_max_concurrent_scans(input:''$input'') { agent { id name } } }' `
                    -and $Request.Variables.input.id -eq 1 `
                    -and $Request.Variables.input.max_concurrent_scans -eq 10
            }
        }
    }
}
