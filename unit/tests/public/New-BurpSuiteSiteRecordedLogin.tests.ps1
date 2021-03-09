InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteSiteRecordedLogin" {
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

            $filePath = Join-Path -Path $PSScriptRoot -ChildPath '..\mocks\recorded_login.json'

            # act
            New-BurpSuiteSiteRecordedLogin -SiteId 42 -Label "login_with_admin_account" -FilePath $filePath

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateSiteRecordedLogin" `
                    -and $Request.Query -eq 'mutation CreateSiteRecordedLogin($input:''CreateSiteRecordedLoginInput!'') { create_site_recorded_login(input:''$input'') { recorded_login { id label } } }' `
                    -and $Request.Variables.Input.site_id -eq 42 `
                    -and $Request.Variables.Input.recorded_login.label -eq "login_with_admin_account" `
                    -and $Request.Variables.Input.recorded_login.script -eq (Get-Content -Raw -Path $filePath | Out-String)
            }
        }
    }
}
