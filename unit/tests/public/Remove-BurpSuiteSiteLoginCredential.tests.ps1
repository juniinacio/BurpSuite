InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteSiteLoginCredential" {
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
            Remove-BurpSuiteSiteLoginCredential -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeleteSiteLoginCredential" `
                    -and $Request.Query -eq 'mutation DeleteSiteLoginCredential($input:''DeleteSiteLoginCredentialInput!'') { delete_site_login_credential(input:''$input'') { id } }' `
                    -and $Request.Variables.Input.id -eq 1
            }
        }
    }
}
