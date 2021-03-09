InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteSiteLoginCredential" {
        It "should create site application login" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        create_site_application_login = [PSCustomObject]@{
                            application_login = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            $credentials = New-Object System.Management.Automation.PSCredential ("administrator", $(ConvertTo-SecureString "changeme" -AsPlainText -Force))

            # act
            New-BurpSuiteSiteLoginCredential -SiteId 42 -Label "admin" -Credential $credentials

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateSiteLoginCredential" `
                    -and $Request.Query -eq 'mutation CreateSiteLoginCredential($input:''CreateSiteLoginCredentialInput!'') { create_site_login_credential(input:''$input'') { login_credential { id label username } } }' `
                    -and $Request.Variables.Input.site_id -eq 42 `
                    -and $Request.Variables.Input.login_credential.label -eq "admin" `
                    -and $Request.Variables.Input.login_credential.username -eq "administrator" `
                    -and $Request.Variables.Input.login_credential.password -eq "changeme"
            }
        }
    }
}
