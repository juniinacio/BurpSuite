InModuleScope $env:BHProjectName {
    Describe "Grant-BurpSuiteAgent" {
        It "should authorize agent" {
            # arrange
            $machineId = '313d80669b7918a2c22e8ffdeff607bc28879fdae50c1c2bb620147e72c473d7'

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        authorize_agent = [PSCustomObject]@{
                            agent = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            Grant-BurpSuiteAgent -MachineId $machineId

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "AuthorizeAgent" `
                    -and $Request.Query -eq 'mutation AuthorizeAgent($input:''AuthorizeAgentInput!'') { authorize_agent(input:''$input'') { agent { id name } } }' `
                    -and $Request.Variables.input.machine_id -eq $machineId
            }
        }
    }
}
