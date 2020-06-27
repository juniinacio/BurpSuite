InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteSite" {
        It "should remove site" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        delete_site = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Remove-BurpSuiteSite -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeleteSite" `
                    -and $Request.Query -eq 'mutation DeleteSite($input:''DeleteSiteInput!'') { delete_site(input:''$input'') { id } }' `
                    -and $Request.Variables.Input.id -eq 1
            }
        }
    }
}
