InModuleScope $env:BHProjectName {
    Describe "Rename-BurpSuiteAgent" {
        It "should rename agent" {
            # arrange
            $id = 4
            $name = "Agent 007"

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        rename_agent = [PSCustomObject]@{
                            agent = [PSCustomObject]@{
                                id = $id
                            }
                        }
                    }
                }
            }

            # act
            Rename-BurpSuiteAgent -Id $id -Name $name

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "RenameAgent" `
                    -and $Request.Query -eq 'mutation RenameAgent($input:''RenameAgentInput!'') { rename_agent(input:''$input'') { agent { id name } } }' `
                    -and $Request.Variables.input.id -eq $id `
                    -and $Request.Variables.input.name -eq $name
            }
        }
    }
}
