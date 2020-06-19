InModuleScope $env:BHProjectName {
    Describe "Update-BurpSuiteFalsePositive" {
        It "should update false positive" {
            # arrange
            $scanId = 1
            $serialNumber = 314276827364273645

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_false_positive = [PSCustomObject]@{
                            successful = $true
                        }
                    }
                }
            }

            # act
            Update-BurpSuiteFalsePositive -ScanId $scanId -SerialNumber $serialNumber -IsFalsePositive -PropagationMode issue_type_only

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "UpdateFalsePositive" `
                    -and $GraphRequest.Query -eq 'mutation UpdateFalsePositive($input:UpdateFalsePositiveInput!) { update_false_positive(input:$input) { successful } }' `
                    -and $GraphRequest.Variables.input.scan_id -eq $scanId `
                    -and $GraphRequest.Variables.input.serial_number -eq $serialNumber `
                    -and $GraphRequest.Variables.input.is_false_positive -eq 'true' `
                    -and $GraphRequest.Variables.input.propagation_mode -eq 'issue_type_only'
            }
        }
    }
}
