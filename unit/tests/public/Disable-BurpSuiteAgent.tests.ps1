InModuleScope $env:BHProjectName {
    Describe "Disable-BurpSuiteAgent" {
        It "should disable agent" {
            # arrange
            $id = 4

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        enable_agent = [PSCustomObject]@{
                            agent = [PSCustomObject]@{
                                id = $id
                            }
                        }
                    }
                }
            }

            # act
            Disable-BurpSuiteAgent -Id $id

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "EnableAgent" `
                    -and $Request.Query -eq 'mutation EnableAgent($input:EnableAgentInput!) { enable_agent(input:$input) { agent { id name } } }' `
                    -and $Request.Variables.input.id -eq $id `
                    -and $Request.Variables.input.enabled -eq $false
            }
        }
    }
}
