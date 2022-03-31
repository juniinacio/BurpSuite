InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteFolder" {
        It "should remove folder" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        delete_folder = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Remove-BurpSuiteFolder -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeleteFolder" `
                    -and $Request.Query -eq 'mutation DeleteFolder($input:DeleteFolderInput!) { delete_folder(input:$input) { id } }' `
                    -and $Request.Variables.Input.id -eq 1
            }
        }
    }
}
