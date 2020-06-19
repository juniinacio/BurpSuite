InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteScheduleItem" {
        It "should remove scedule item" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        delete_schedule_item = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Remove-BurpSuiteScheduleItem -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeleteScheduleItem" `
                    -and $Request.Query -eq 'mutation DeleteScheduleItem($input:DeleteScheduleItemInput!) { delete_schedule_item(input:$input) { id } }' `
                    -and $Request.Variables.Input.id -eq 1
            }
        }
    }
}
