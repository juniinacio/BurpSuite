InModuleScope $env:BHProjectName {
    Describe "Stop-BurpSuiteScan" {
        It "should cancel scan" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        cancel_scan = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Stop-BurpSuiteScan -Id 1 -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "CancelScan" `
                    -and $GraphRequest.Query -eq 'mutation CancelScan($input:CancelScanInput!) { cancel_scan(input:$input) { id } }' `
                    -and $GraphRequest.Variables.Input.id -eq 1
            }
        }
    }
}
