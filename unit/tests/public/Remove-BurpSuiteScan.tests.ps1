InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteScan" {
        It "should remove scan" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        delete_scan = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Remove-BurpSuiteScan -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "DeleteScan" `
                    -and $GraphRequest.Query -eq 'mutation DeleteScan($input:DeleteScanInput!) { delete_scan(input:$input) { id } }' `
                    -and $GraphRequest.Variables.Input.id -eq 1
            }
        }
    }
}
