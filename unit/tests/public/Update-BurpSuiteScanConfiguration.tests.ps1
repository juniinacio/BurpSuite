InModuleScope $env:BHProjectName {
    Describe "Update-BurpSuiteScanConfiguration" {
        It "should update scan configuration" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_scan_configuration = [PSCustomObject]@{
                            scan_configuration = [PSCustomObject]@{
                                id = 1
                                name = 'foo'
                                scan_configuration_fragment_json = '{}'
                            }
                        }
                    }
                }
            }

            $filePath = Join-Path -Path $PSScriptRoot -ChildPath '..\mocks\scan_configuration.json'

            # act
            Update-BurpSuiteScanConfiguration -Id 1 -Name 'foo' -FilePath $filePath

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "UpdateScanConfiguration" `
                    -and $GraphRequest.Query -eq 'mutation UpdateScanConfiguration($input:UpdateScanConfigurationInput!) { update_scan_configuration(input:$input) { scan_configuration { id name scan_configuration_fragment_json built_in last_modified_by { username } last_modified_time } } }' `
                    -and $GraphRequest.Variables.Input.id -eq 1 `
                    -and $GraphRequest.Variables.Input.name -eq 'foo' `
                    -and $GraphRequest.Variables.Input.scan_configuration_fragment_json -eq (Get-Content -Raw -Path $filePath | Out-String)
            }
        }

        It "should update scan configuration name" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_configuration = [PSCustomObject]@{
                            id = 1
                            name = 'foo'
                            scan_configuration_fragment_json = '{}'
                        }
                    }
                }
            }

            # act
            Update-BurpSuiteScanConfiguration -Id 1 -Name 'foo'

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "UpdateScanConfiguration" `
                    -and $GraphRequest.Query -eq 'mutation UpdateScanConfiguration($input:UpdateScanConfigurationInput!) { update_scan_configuration(input:$input) { scan_configuration { id name scan_configuration_fragment_json built_in last_modified_by { username } last_modified_time } } }' `
                    -and $GraphRequest.Variables.Input.id -eq 1 `
                    -and $GraphRequest.Variables.Input.name -eq 'foo' `
                    -and $GraphRequest.Variables.Input.ContainsKey('scan_configuration_fragment_json') -eq $false
            }
        }

        It "should update scan configuration settings" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_configuration = [PSCustomObject]@{
                            id = 1
                            name = 'foo'
                            scan_configuration_fragment_json = '{}'
                        }
                    }
                }
            }

            $filePath = Join-Path -Path $PSScriptRoot -ChildPath '..\mocks\scan_configuration.json'

            # act
            Update-BurpSuiteScanConfiguration -Id 1 -FilePath $filePath

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "UpdateScanConfiguration" `
                    -and $GraphRequest.Query -eq 'mutation UpdateScanConfiguration($input:UpdateScanConfigurationInput!) { update_scan_configuration(input:$input) { scan_configuration { id name scan_configuration_fragment_json built_in last_modified_by { username } last_modified_time } } }' `
                    -and $GraphRequest.Variables.Input.id -eq 1 `
                    -and $GraphRequest.Variables.Input.ContainsKey('name') -eq $false `
                    -and $GraphRequest.Variables.Input.scan_configuration_fragment_json -eq (Get-Content -Raw -Path $filePath | Out-String)
            }
        }
    }
}
