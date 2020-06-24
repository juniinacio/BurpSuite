InModuleScope $env:BHProjectName {
    Describe "Update-BurpSuiteSiteApplicationLogin" {
        It "should udate site application login" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_site_application_login = [PSCustomObject]@{
                            application_login = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            $credentials = New-Object System.Management.Automation.PSCredential ("administrator", $(ConvertTo-SecureString "changeme" -AsPlainText -Force))

            # act
            Update-BurpSuiteSiteApplicationLogin -Id 42 -Label "admin" -Credential $credentials

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateSiteApplicationLogin" `
                    -and $Request.Query -eq 'mutation UpdateSiteApplicationLogin($input:''UpdateSiteApplicationLoginInput!'') { update_site_application_login(input:''$input'') { application_login { id label username } } }' `
                    -and $Request.Variables.Input.id -eq 42 `
                    -and $Request.Variables.Input.label -eq "admin" `
                    -and $Request.Variables.Input.username -eq "administrator" `
                    -and $Request.Variables.Input.password -eq "changeme"
            }
        }
    }
}