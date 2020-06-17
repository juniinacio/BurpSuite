InModuleScope $env:BHProjectName {
    Describe "Get-BurpSuiteAgent" {
        It "should get agents" {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteAgent

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetAgents" `
                    -and $GraphRequest.Query -like "query GetAgents { agents { * } }"
            }
        }

        It "should get agent" {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteAgent -ID 12345

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.OperationName -eq "GetAgent" `
                    -and $GraphRequest.Query -like 'query GetAgent($id:ID!) { agent(id:$id) { * } }' `
                    -and $GraphRequest.Variables.id -eq 12345
            }
        }

        It "should add <FieldName> selection field" -TestCases @(
            @{ FieldName = "id" }
            @{ FieldName = "machine_id" }
            @{ FieldName = "current_scan_count" }
            @{ FieldName = "ip" }
            @{ FieldName = "name" }
            @{ FieldName = "state" }
            @{ FieldName = "enabled" }
            @{ FieldName = "max_concurrent_scans" }
        ) {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteAgent -ID 1 -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.Query -like "query GetAgent(`$id:ID!) { agent(id:`$id) {* $FieldName *} }"
            }
        }

        It "should add <FieldName> sub selection field" -TestCases @(
            @{ FieldName = "error"; Query = "error { code error }" }
        ) {
            # arrange
            Mock -CommandName _callAPI

            # act
            Get-BurpSuiteAgent -Fields $FieldName

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.Query -like "query GetAgents { agents { *$query* } }"
            }
        }
    }
}
