InModuleScope $env:BHProjectName {
    Describe "Revoke-BurpSuiteAgent" {
        It "should deauthorize agent" {
            # arrange
            $machineId = '313d80669b7918a2c22e8ffdeff607bc28879fdae50c1c2bb620147e72c473d7'

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        deauthorize_agent = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Revoke-BurpSuiteAgent -MachineId $machineId

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeauthorizeAgent" `
                    -and $Request.Query -eq 'mutation DeauthorizeAgent($input:DeauthorizeAgentInput!) { deauthorize_agent(input:$input) { id } }' `
                    -and $Request.Variables.input.machine_id -eq $machineId
            }
        }
    }
}
