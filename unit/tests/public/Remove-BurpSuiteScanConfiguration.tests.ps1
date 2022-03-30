InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteScanConfiguration" {
        It "should remove scan configuration" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        delete_scan_configuration = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Remove-BurpSuiteScanConfiguration -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeleteScanConfiguration" `
                    -and $Request.Query -eq 'mutation DeleteScanConfiguration($input:DeleteScanConfigurationInput!) { delete_scan_configuration(input:$input) { id } }' `
                    -and $Request.Variables.Input.id -eq 1
            }
        }
    }
}
