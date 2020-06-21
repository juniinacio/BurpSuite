InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteSiteApplicationLogin" {
        It "should remove site" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        delete_site_application_login = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Remove-BurpSuiteSiteApplicationLogin -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeleteSiteApplicationLogin" `
                    -and $Request.Query -eq 'mutation DeleteSiteApplicationLogin($input:''DeleteSiteApplicationLoginInput!'') { delete_site_application_login(input:''$input'') { id } }' `
                    -and $Request.Variables.Input.id -eq 1
            }
        }
    }
}
