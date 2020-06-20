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
                $Request.OperationName -eq "CancelScan" `
                    -and $Request.Query -eq 'mutation CancelScan($input:''CancelScanInput!'') { cancel_scan(input:''$input'') { id } }' `
                    -and $Request.Variables.Input.id -eq 1
            }
        }
    }
}
