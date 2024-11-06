InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteSite" {
        It "should create site" {
            # arrange
            $name = "Example Site"
            $parentId = 0
            $filePath = Join-Path -Path $PSScriptRoot -ChildPath '..\mocks\recorded_login.json'
            $scopeInput = [PSCustomObject]@{
                StartUrls = @("http://example.com")
                InScopeUrlPrefixes = @()
                OutOfScopeUrlPrefixes = @()
                ProtocolOptions = 'USE_HTTP_AND_HTTPS'
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
            New-BurpSuiteSite -Name $name -ParentId $parentId -ScopeV2 $scopeInput -ScanConfigurationIds $scanConfigurationIds -EmailRecipients $emailRecipientInput -LoginCredentials $loginCredentialsInput -RecordedLogins $recordedLoginsInput -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateSite" `
                    -and $Request.Query -eq 'mutation CreateSite($input:CreateSiteInput!) { create_site(input:$input) { site { id name parent_id scope_v2 { start_urls in_scope_url_prefixes out_of_scope_url_prefixes protocol_options } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } } } }' `
                    -and $Request.Variables.Input.name -eq $name `
                    -and $Request.Variables.Input.parent_id -eq $parentId `
                    -and ($Request.Variables.Input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',') `
                    -and $Request.Variables.Input.email_recipients[0].email -eq $emailRecipientInput[0].email `
                    -and ($Request.Variables.Input.scope_v2.start_urls -join ',') -eq ($scopeInput.StartUrls -join ',') `
                    -and ($Request.Variables.Input.scope_v2.in_scope_url_prefixes -join ',') -eq ($scopeInput.InScopeUrlPrefixes -join ',') `
                    -and ($Request.Variables.Input.scope_v2.out_of_scope_url_prefixes -join ',') -eq ($scopeInput.OutOfScopeUrlPrefixes -join ',') `
                    -and $Request.Variables.Input.scope_v2.protocol_options -eq $scopeInput.ProtocolOptions `
                    -and $Request.Variables.Input.application_logins.login_credentials[0].label -eq $loginCredentialsInput[0].label `
                    -and $Request.Variables.Input.application_logins.login_credentials[0].username -eq (($loginCredentialsInput[0].Credential).GetNetworkCredential()).username `
                    -and $Request.Variables.Input.application_logins.login_credentials[0].password -eq (($loginCredentialsInput[0].Credential).GetNetworkCredential()).password `
                    -and $Request.Variables.Input.application_logins.recorded_logins[0].label -eq $recordedLoginsInput[0].label `
                    -and $Request.Variables.Input.application_logins.recorded_logins[0].script -eq (Get-Content -Raw -Path $filePath | Out-String)
            }
        }
    }
}
