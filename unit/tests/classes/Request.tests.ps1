InModuleScope $env:BHProjectName {
    Describe "Request" {
        Context "Constructors" {
            It "constructor should set query property" {
                # arrange
                $query = '{ __schema { queryType { name } } }'

                # act
                $assert = [Request]::new($query)

                # assert
                $assert.Query | Should -Be $query
            }

            It "constructor should set both query and operation name property" {
                # arrange
                $query = '{ __schema { queryType { name } } }'
                $operationName = '__schema'

                # act
                $assert = [Request]::new($query, $operationName)

                # assert
                $assert.Query | Should -Be $query
                $assert.OperationName | Should -Be '__schema'
            }

            It "constructor should set both query and variables property" {
                # arrange
                $query = '{ __schema { queryType { name } } }'
                $variables = @{Foo = 'Bar' }

                # act
                $assert = [Request]::new($query, $variables)

                # assert
                $assert.Query | Should -Be $query
                $assert.Variables.Foo | Should -Be 'Bar'
            }

            It "constructor should set both query, operation name and variables property" {
                # arrange
                $query = '{ __schema { queryType { name } } }'
                $operationName = '__schema'
                $variables = @{Foo = 'Bar' }

                # act
                $assert = [Request]::new($query, $operationName, $variables)

                # assert
                $assert.Query | Should -Be $query
                $assert.OperationName | Should -Be '__schema'
                $assert.Variables.Foo | Should -Be 'Bar'
            }
        }
    }
}
