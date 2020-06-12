InModuleScope $env:BHProjectName {
    Describe "GraphRequest" {
        Context "Constructors" {
            It "constructor should set query property" {
                # arrange
                $query = '{ __schema { queryType { name } } }'

                # act
                $assert = [GraphRequest]::new($query)

                # assert
                $assert.Query | Should -Be $query
            }

            It "constructor should set both query and variables property" {
                # arrange
                $query = '{ __schema { queryType { name } } }'
                $variables = @{Foo = 'Bar'}

                # act
                $assert = [GraphRequest]::new($query, $variables)

                # assert
                $assert.Query | Should -Be $query
                $assert.Variables.Foo | Should -Be 'Bar'
            }
        }
    }
}
