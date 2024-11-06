InModuleScope $env:BHProjectName {
    Describe "Update-BurpSuiteSiteScanConfiguration" {
        It "should Update site scan configuration" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_site_scan_configurations = [PSCustomObject]@{
                            site = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            Update-BurpSuiteSiteScanConfiguration -Id 42 -ScanConfigurationIds "fc5b5ab2-cde5-41bc-ac62-fab3502ae38e"

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateSiteScanConfigurations" `
                    -and $Request.Query -eq 'mutation UpdateSiteScanConfigurations($input:UpdateSiteScanConfigurationsInput!) { update_site_scan_configurations(input:$input) { site { id name parent_id scope_v2 { start_urls in_scope_url_prefixes out_of_scope_url_prefixes protocol_options } scan_configurations { id } application_logins { login_credentials { id label username } recorded_logins { id label } } ephemeral email_recipients { id email } } } }' `
                    -and $Request.Variables.Input.id -eq 42 `
                    -and $Request.Variables.Input.scan_configuration_ids[0] -eq "fc5b5ab2-cde5-41bc-ac62-fab3502ae38e"
            }
        }
    }
}
