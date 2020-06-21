InModuleScope $env:BHProjectName {
    Describe "Rename-BurpSuiteSite" {
        It "should rename site" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        rename_site = [PSCustomObject]@{
                            site = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            Rename-BurpSuiteSite -Id 42 -Name "Example Site"

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "RenameSite" `
                    -and $Request.Query -eq 'mutation RenameSite($input:''RenameSiteInput!'') { rename_site(input:''$input'') { site { id name parent_id scope { included_urls excluded_urls } scan_configurations { id name } application_logins { id label username } ephemeral email_recipients { id email } } } }' `
                    -and $Request.Variables.Input.id -eq 42 `
                    -and $Request.Variables.Input.name -eq "Example Site"
            }
        }
    }
}
