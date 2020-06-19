Describe "Module" {
    Context "Accelerator" {
        It "should add Request type accelerator" {
            # arrange

            # act

            # assert
            { [BurpSuiteRequest]::new('{ __schema { queryType { name } } }') } | Should -Not -Throw
        }

        It "should create [Request] instance" {
            # arrange

            # act
            $assert = [BurpSuiteRequest]::new('{ __schema { queryType { name } } }')

            # assert
            $assert | Should -Not -BeNullOrEmpty
            $assert.Query | Should -Be '{ __schema { queryType { name } } }'
        }
    }
}
