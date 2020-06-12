Describe "Module" {
    Context "Accelerator" {
        It "should add GraphRequest type accelerator" {
            # arrange

            # act

            # assert
            { [GraphRequest]::new('{ __schema { queryType { name } } }') } | Should -Not -Throw
        }

        It "should create [GraphRequest] instance" {
            # arrange

            # act
            $assert = [GraphRequest]::new('{ __schema { queryType { name } } }')

            # assert
            $assert | Should -Not -BeNullOrEmpty
            $assert.Query | Should -Be '{ __schema { queryType { name } } }'
        }
    }
}
