InModuleScope $env:BHProjectName {
    Describe "Move-BurpSuiteFolder" {
        It "should move folder" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        move_folder = [PSCustomObject]@{
                            folder = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            Move-BurpSuiteFolder -FolderId 2 -ParentId 1

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "MoveFolder" `
                    -and $Request.Query -eq 'mutation MoveFolder($input:MoveFolderInput!) { move_folder(input:$input) { folder { id name parent_id } } }' `
                    -and $Request.Variables.Input.folder_id -eq 2 `
                    -and $Request.Variables.Input.parent_id -eq 1
            }
        }
    }
}
