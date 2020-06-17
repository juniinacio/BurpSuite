InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteScanConfiguration" {
        It "should create scan configuration" {
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
            New-BurpSuiteScanConfiguration -Name 'foo' -FilePath $filePath

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "CreateScanConfiguration" `
                    -and $GraphRequest.Query -eq 'mutation CreateScanConfiguration($input:CreateScanConfigurationInput!) { create_scan_configuration(input:$input) { scan_configuration { id name scan_configuration_fragment_json built_in last_modified_by { username } last_modified_time } } }' `
                    -and $GraphRequest.Variables.Input.name -eq 'foo' `
                    -and $GraphRequest.Variables.Input.scan_configuration_fragment_json -eq (Get-Content -Raw -Path $filePath | Out-String)
            }
        }
    }
}
