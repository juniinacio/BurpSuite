InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteScanConfiguration" {
        It "should get scan configurations" {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteScanConfiguration

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetScanConfigurations" `
                    -and $GraphRequest.Query -eq "query GetScanConfigurations { scan_configurations { id name } }"
            }
        }

        It "should set scan configurations field properties" {
            # arrange
            $fields = 'id', 'name', 'scan_configuration_fragment_json', 'built_in', 'last_modified_time', 'last_modified_by'

            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteScanConfiguration -Fields $fields

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetScanConfigurations" `
                    -and $GraphRequest.Query -eq "query GetScanConfigurations { scan_configurations { $($fields -join ' ') } }"
            }
        }

        It "should get scan configuration by ID" {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteScanConfiguration -ID 12345

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetScanConfiguration" `
                    -and $GraphRequest.Query -eq 'query GetScanConfiguration($scanId:ID!) { scan_configurations(scan_id:$scanId) { id name } }'
            }
        }
    }
}
