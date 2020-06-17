InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteScanConfiguration" {
        It "should remove scan configuration" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        create_scan_configuration = [PSCustomObject]@{
                            scan_configuration = [PSCustomObject]@{
                                id = 1
                                name = 'foo'
                                scan_configuration_fragment_json = '{}'
                            }
                        }
                    }
                }
            }

            # act
            Remove-BurpSuiteScanConfiguration -Id 1 -Name 'foo' -FilePath $filePath

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "UpdateScanConfiguration" `
                    -and $GraphRequest.Query -eq 'mutation UpdateScanConfiguration($input:UpdateScanConfigurationInput!) { update_scan_configuration(input:$input) { scan_configuration { id name scan_configuration_fragment_json built_in last_modified_by { username } last_modified_time } } }' `
                    -and $GraphRequest.Variables.Input.id -eq 1 `
                    -and $GraphRequest.Variables.Input.name -eq 'foo' `
                    -and $GraphRequest.Variables.Input.scan_configuration_fragment_json -eq (Get-Content -Raw -Path $filePath | Out-String)
            }
        }
    }
}
