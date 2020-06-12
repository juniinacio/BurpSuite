InModuleScope $env:BHProjectName {
    Describe "Invoke-BurpSuiteAPI" {
        It "should invoke BurpSuite Graph API" {
            # arrange
            $graphRequest = [GraphRequest]::new('{ __schema { queryType { name } } }')

            Mock -CommandName _callAPI

            # act
            Invoke-BurpSuiteAPI -GraphRequest $graphRequest -Confirm:$false

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $GraphRequest.query -eq "{ __schema { queryType { name } } }"
            }
        }
    }
}
