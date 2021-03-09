InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteSiteRecordedLogin" {
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
            Remove-BurpSuiteSiteRecordedLogin -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeleteSiteRecordedLogin" `
                    -and $Request.Query -eq 'mutation DeleteSiteRecordedLogin($input:''DeleteSiteRecordedLoginInput!'') { delete_site_recorded_login(input:''$input'') { id } }' `
                    -and $Request.Variables.Input.id -eq 1
            }
        }
    }
}
