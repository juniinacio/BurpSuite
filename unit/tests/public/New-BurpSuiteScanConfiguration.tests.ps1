InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteScanConfiguration" {
        It "should create scan configuration" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_configuration = [PSCustomObject]@{
                            id                               = 1
                            name                             = 'foo'
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
                $Request.OperationName -eq "CreateScanConfiguration" `
                    -and $Request.Query -eq 'mutation CreateScanConfiguration($input:''CreateScanConfigurationInput!'') { create_scan_configuration(input:''$input'') { scan_configuration { id name } } }' `
                    -and $Request.Variables.Input.name -eq 'foo' `
                    -and $Request.Variables.Input.scan_configuration_fragment_json -eq (Get-Content -Raw -Path $filePath | Out-String)
            }
        }
    }
}
