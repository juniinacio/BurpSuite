InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteSiteApplicationLogin" {
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
            New-BurpSuiteSiteApplicationLogin -SiteId 42 -Label "admin" -Credential $credentials

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateSiteApplicationLogin" `
                    -and $Request.Query -eq 'mutation CreateSiteApplicationLogin($input:''CreateSiteApplicationLoginInput!'') { create_site_application_login(input:''$input'') { application_login { id label username } } }' `
                    -and $Request.Variables.Input.site_id -eq 42 `
                    -and $Request.Variables.Input.application_login.label -eq "admin" `
                    -and $Request.Variables.Input.application_login.username -eq "administrator" `
                    -and $Request.Variables.Input.application_login.password -eq "changeme"
            }
        }
    }
}
