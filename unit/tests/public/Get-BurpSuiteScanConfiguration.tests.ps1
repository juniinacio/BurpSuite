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
                $Request.Query -eq "query { scan_configurations { id name } }"
            }
        }

        It "should set scan configurations <FieldName> selection field" -TestCases @(
            @{ FieldName = "id" }
            @{ FieldName = "name" }
            @{ FieldName = "scan_configuration_fragment_json" }
            @{ FieldName = "built_in" }
            @{ FieldName = "last_modified_time" }
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
                $Request.Query -eq "query { scan_configurations { $FieldName } }"
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
                $Request.Query -like "query { scan_configurations { *$Query* } }"
            }
        }
    }
}
