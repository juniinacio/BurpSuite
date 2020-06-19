InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteAgent" {
        It "should get agents" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        agents = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteAgent

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "GetAgents" `
                    -and $Request.Query -like "query GetAgents { agents { * } }"
            }
        }

        It "should get agent" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        agent = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteAgent -ID 1

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "GetAgent" `
                    -and $Request.Query -like 'query GetAgent($id:ID!) { agent(id:$id) { * } }' `
                    -and $Request.Variables.id -eq 1
            }
        }

        It "should add <FieldName> selection field" -TestCases @(
            @{ FieldName = "id" }
            @{ FieldName = "machine_id" }
            @{ FieldName = "current_scan_count" }
            @{ FieldName = "ip" }
            @{ FieldName = "name" }
            @{ FieldName = "state" }
            @{ FieldName = "enabled" }
            @{ FieldName = "max_concurrent_scans" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        agent = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteAgent -ID 1 -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query GetAgent(`$id:ID!) { agent(id:`$id) {* $FieldName *} }"
            }
        }

        It "should add <FieldName> sub selection field" -TestCases @(
            @{ FieldName = "error"; Query = "error { code error }" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        agents = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteAgent -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query GetAgents { agents { *$query* } }"
            }
        }
    }
}
