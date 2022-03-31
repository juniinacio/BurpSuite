InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteSite" {
        It "should create site" {
            # arrange
            $name = "Example Site"
            $parentId = 0
            $filePath = Join-Path -Path $PSScriptRoot -ChildPath '..\mocks\recorded_login.json'
            $scopeInput = [PSCustomObject]@{
                IncludedUrls = @("http://example.com")
                ExcludedUrls = @()
            }
            $emailRecipientInput = @(
                [PSCustomObject]@{
                    Email = "foo@example.com"
                }
            )
            $loginCredentialsInput = @(
                [PSCustomObject]@{
                    Label      = "Admin"
                    Credential = (New-Object System.Management.Automation.PSCredential ("admin", $(ConvertTo-SecureString "ChangeMe" -AsPlainText -Force)))
                }
            )
            $recordedLoginsInput = @(
                [PSCustomObject]@{
                    Label      = "Admin"
                    FilePath = $filePath
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
            New-BurpSuiteSite -Name $name -ParentId $parentId -Scope $scopeInput -ScanConfigurationIds $scanConfigurationIds -EmailRecipients $emailRecipientInput -LoginCredentials $loginCredentialsInput -RecordedLogins $recordedLoginsInput -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateSite" `
                    -and $Request.Query -eq 'mutation CreateSite($input:CreateSiteInput!) { create_site(input:$input) { site { id name parent_id scope { included_urls excluded_urls } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } } } }' `
                    -and $Request.Variables.Input.name -eq $name `
                    -and $Request.Variables.Input.parent_id -eq $parentId `
                    -and ($Request.Variables.Input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',') `
                    -and $Request.Variables.Input.email_recipients[0].email -eq $emailRecipientInput[0].email `
                    -and ($Request.Variables.Input.scope.included_urls -join ',') -eq ($scopeInput.IncludedUrls -join ',') `
                    -and ($Request.Variables.Input.scope.excluded_urls -join ',') -eq ($scopeInput.ExcludedUrls -join ',') `
                    -and $Request.Variables.Input.application_logins.login_credentials[0].label -eq $loginCredentialsInput[0].label `
                    -and $Request.Variables.Input.application_logins.login_credentials[0].username -eq (($loginCredentialsInput[0].Credential).GetNetworkCredential()).username `
                    -and $Request.Variables.Input.application_logins.login_credentials[0].password -eq (($loginCredentialsInput[0].Credential).GetNetworkCredential()).password `
                    -and $Request.Variables.Input.application_logins.recorded_logins[0].label -eq $recordedLoginsInput[0].label `
                    -and $Request.Variables.Input.application_logins.recorded_logins[0].script -eq (Get-Content -Raw -Path $filePath | Out-String)
            }
        }
    }
}
