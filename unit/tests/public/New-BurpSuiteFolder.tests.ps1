InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteFolder" {
        It "should create folder" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        create_folder = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            New-BurpSuiteFolder -ParentId "0" -Name 'Production' -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateFolder" `
                    -and $Request.Query -eq 'mutation CreateFolder($input:''CreateFolderInput!'') { create_folder(input:''$input'') { folder { id name parent_id } } }' `
                    -and $Request.Variables.Input.name -eq "Production" `
                    -and $Request.Variables.Input.parent_id -eq "0"
            }
        }
    }
}
