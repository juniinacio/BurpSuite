InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteSite" {
        It "should create site" {
            # arrange
            $name = "Example Site"
            $parentId = 0
            $scope = @{
                included_urls = @("http://example.com")
                excluded_urls = @()
            }
            # $applicationLogins = @(
            #     @{
            #         label = "http://example.com"
            #         username = "foo"
            #         password = "bar"
            #     }
            # )
            $scanConfigurationIds = "1"
            $emailRecipients = "foo@example.com"

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
            New-BurpSuiteSite -Name $name -ParentId $parentId -IncludedUrls $scope.included_urls  -ExcludedUrls $scope.excluded_urls -ScanConfigurationIds $scanConfigurationIds -EmailRecipients $emailRecipients -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateSite" `
                    -and $Request.Query -eq 'mutation CreateSite($input:''CreateSiteInput!'') { create_site(input:''$input'') { site { id name parent_id scope { included_urls excluded_urls } scan_configurations { id name } application_logins { id label username } ephemeral email_recipients { id email } } } }' `
                    -and $Request.Variables.Input.name -eq $name `
                    -and $Request.Variables.Input.parent_id -eq $parentId `
                    -and ($Request.Variables.Input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',') `
                    -and $Request.Variables.Input.email_recipients[0].email -eq $emailRecipients `
                    -and ($Request.Variables.Input.scope.included_urls -join ',') -eq ($scope.included_urls -join ',') `
                    -and ($Request.Variables.Input.scope.excluded_urls -join ',') -eq ($scope.excluded_urls -join ',') `
                    # -and $Request.Variables.Input.application_logins[0].label -eq $applicationLogins.label `
                    # -and $Request.Variables.Input.application_logins[0].username -eq $applicationLogins.username `
                    # -and $Request.Variables.Input.application_logins[0].password -eq $applicationLogins.password
            }
        }
    }
}
