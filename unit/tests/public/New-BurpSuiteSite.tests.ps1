InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteSite" {
        It "should create site" {
            # arrange
            $name = "Example Site"
            $parentId = 0
            $scope = [PSCustomObject]@{
                IncludedUrls = @("http://example.com")
                ExcludedUrls = @()
            }
            $emailRecipients = @([PSCustomObject]@{
                Email = "foo@example.com"
            })
            $applicationLogins = @(
                [PSCustomObject]@{
                    Label = "Admin"
                    Username = "admin"
                    Password = "ChangeMe"
                }
            )
            $scanConfigurationIds = "1"

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        create_site = [PSCustomObject]@{
                            site = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            New-BurpSuiteSite -Name $name -ParentId $parentId -Scope $scope -ScanConfigurationIds $scanConfigurationIds -EmailRecipients $emailRecipients -ApplicationLogins $applicationLogins -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateSite" `
                    -and $Request.Query -eq 'mutation CreateSite($input:''CreateSiteInput!'') { create_site(input:''$input'') { site { id name parent_id scope { included_urls excluded_urls } scan_configurations { id } application_logins { id label username } ephemeral email_recipients { id email } } } }' `
                    -and $Request.Variables.Input.name -eq $name `
                    -and $Request.Variables.Input.parent_id -eq $parentId `
                    -and ($Request.Variables.Input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',') `
                    -and $Request.Variables.Input.email_recipients[0].email -eq $emailRecipients[0].email `
                    -and ($Request.Variables.Input.scope.included_urls -join ',') -eq ($scope.IncludedUrls -join ',') `
                    -and ($Request.Variables.Input.scope.excluded_urls -join ',') -eq ($scope.ExcludedUrls -join ',') `
                    -and $Request.Variables.Input.application_logins[0].label -eq $applicationLogins[0].label `
                    -and $Request.Variables.Input.application_logins[0].username -eq $applicationLogins[0].username `
                    -and $Request.Variables.Input.application_logins[0].password -eq $applicationLogins[0].password
            }
        }
    }
}
