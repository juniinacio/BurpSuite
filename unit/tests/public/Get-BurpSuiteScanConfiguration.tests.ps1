InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteScanConfiguration" {
        It "should get scan configurations" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_configurations = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteScanConfiguration

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "GetScanConfigurations" `
                    -and $Request.Query -eq "query GetScanConfigurations { scan_configurations { id name } }"
            }
        }

        It "should set scan configurations selection fields" {
            # arrange
            $fields = 'id', 'name', 'scan_configuration_fragment_json', 'built_in', 'last_modified_time'

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_configurations = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteScanConfiguration -Fields $fields

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "GetScanConfigurations" `
                    -and $Request.Query -eq "query GetScanConfigurations { scan_configurations { $($fields -join ' ') } }"
            }
        }

        It "should add <FieldName> sub selection field" -TestCases @(
            @{ FieldName = "last_modified_by"; Query = "last_modified_by { username }" }
        ) {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        scan_configurations = @(
                            [PSCustomObject]@{
                                id = 1
                            }
                        )
                    }
                }
            }

            # act
            Get-BurpSuiteScanConfiguration -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.Query -like "query GetScanConfigurations { scan_configurations { *$Query* } }"
            }
        }
    }
}
