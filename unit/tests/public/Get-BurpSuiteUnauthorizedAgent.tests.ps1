InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteUnauthorizedAgent" {
        It "should add <FieldName> selection field" -TestCases @(
            @{ FieldName = "machine_id" }
            @{ FieldName = "ip" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_item = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Get-BurpSuiteUnauthorizedAgent -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query { unauthorized_agents { $FieldName } }"
            }
        }
    }
}
