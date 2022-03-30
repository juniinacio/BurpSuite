InModuleScope $env:BHProjectName {
    Describe "Rename-BurpSuiteFolder" {
        It "should rename folder" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        rename_folder = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Rename-BurpSuiteFolder -Id "1" -Name 'Production' -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "RenameFolder" `
                    -and $Request.Query -eq 'mutation RenameFolder($input:RenameFolderInput!) { rename_folder(input:$input) { folder { id name parent_id } } }' `
                    -and $Request.Variables.Input.name -eq "Production" `
                    -and $Request.Variables.Input.id -eq "1"
            }
        }
    }
}
