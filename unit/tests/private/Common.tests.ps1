InModuleScope BurpSuite {
    Describe "Common" {
        Context "_createSession" {
            It "should set session url and API key" {
                # arrange
                [Session]::Dispose()

                $apiKey = 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX'
                $uri = 'https://burpsuite.example.org:443/graphql/v1'

                # act
                _createSession -APIKey $apiKey -APIUrl $uri

                # assert
                [Session]::APIKey | Should -Be $apiKey
                [Session]::APIUrl | Should -Be $uri

                [Session]::Dispose()
            }
        }

        Context "_callAPI" {
            It "should set authorization header" {
                # arrange
                $apiKey = 'xxxAAAxxxx'

                [Session]::APIKey = $apiKey
                [Session]::APIUrl = 'https://burpsuite.foo.org:443/graphql/v1'

                $request = [GraphRequest]::new('{ __schema { queryType { name } } }')

                Mock -CommandName Invoke-RestMethod

                # act
                _callAPI -GraphRequest $request

                # assert
                Should -Invoke Invoke-RestMethod -ParameterFilter {
                    $Headers.Authorization -eq $apiKey
                }
            }

            It "should set request uri" {
                # arrange
                $apiKey = 'xxxAAAxxxx'

                [Session]::APIKey = $apiKey
                [Session]::APIUrl = 'https://burpsuite.foo.org:443/graphql/v1'

                $request = [GraphRequest]::new('{ __schema { queryType { name } } }')

                Mock -CommandName Invoke-RestMethod

                # act
                _callAPI -GraphRequest $request

                # assert
                Should -Invoke Invoke-RestMethod -ParameterFilter {
                    $Uri -eq "https://burpsuite.foo.org:443/graphql/v1"
                }
            }

            It "should set request body" {
                # arrange
                $apiKey = 'xxxAAAxxxx'

                [Session]::APIKey = $apiKey
                [Session]::APIUrl = 'https://burpsuite.foo.org:443/graphql/v1'

                $request = [GraphRequest]::new('{ __schema { queryType { name } } }')

                Mock -CommandName Invoke-RestMethod

                # act
                _callAPI -GraphRequest $request

                # assert
                Should -Invoke Invoke-RestMethod -ParameterFilter {
                    $Body -like "*query*{ __schema { queryType { name } } }*"
                }
            }

            It "should set method to post" {
                # arrange
                $apiKey = 'xxxAAAxxxx'

                [Session]::APIKey = $apiKey
                [Session]::APIUrl = 'https://burpsuite.foo.org:443/graphql/v1'

                $request = [GraphRequest]::new('{ __schema { queryType { name } } }')

                Mock -CommandName Invoke-RestMethod

                # act
                _callAPI -GraphRequest $request

                # assert
                Should -Invoke Invoke-RestMethod -ParameterFilter {
                    $Method -eq "Post"
                }
            }

            It "should set content type header" {
                # arrange
                $apiKey = 'xxxAAAxxxx'

                [Session]::APIKey = $apiKey
                [Session]::APIUrl = 'https://burpsuite.foo.org:443/graphql/v1'

                $request = [GraphRequest]::new('{ __schema { queryType { name } } }')

                Mock -CommandName Invoke-RestMethod

                # act
                _callAPI -GraphRequest $request

                # assert
                Should -Invoke Invoke-RestMethod -ParameterFilter {
                    $Headers.'Content-Type' -eq "application/json"
                }
            }

            It "should accept header" {
                # arrange
                $apiKey = 'xxxAAAxxxx'

                [Session]::APIKey = $apiKey
                [Session]::APIUrl = 'https://burpsuite.foo.org:443/graphql/v1'

                $request = [GraphRequest]::new('{ __schema { queryType { name } } }')

                Mock -CommandName Invoke-RestMethod

                # act
                _callAPI -GraphRequest $request

                # assert
                Should -Invoke Invoke-RestMethod -ParameterFilter {
                    $Headers.Accept -eq "application/json"
                }
            }
        }

        Context "_removeSession" {
            It "should clear session uri and API key" {
                # arrange
                [Session]::APIKey = 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX'
                [Session]::APIUrl = 'https://burpsuite.example.org'

                # act
                _removeSession

                # assert
                [Session]::APIKey | Should -BeNullOrEmpty
                [Session]::APIUrl | Should -BeNullOrEmpty

                [Session]::Dispose()
            }
        }

        Context "_assertAPIKey" {
            It "should throw exception if API key is not set" {
                # arrange
                [Session]::APIKey = ''

                # act
                { _assertAPIKey } | Should -Throw

                # assert
            }

            It "should not throw exception if API key is set" {
                # arrange
                [Session]::APIKey = 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX'

                # act
                { _assertAPIKey } | Should -Not -Throw

                # assert
            }
        }

        Context "_assertAPIUrl" {
            It "should throw exception if API url is not set" {
                # arrange
                [Session]::APIUrl = ''

                # act
                { _assertAPIUrl } | Should -Throw

                # assert
            }

            It "should not throw exception if API url is set" {
                # arrange
                [Session]::APIUrl = 'https://burpsuite.example.org'

                # act
                { _assertAPIUrl } | Should -Not -Throw

                # assert
            }
        }

        Context "_registerAccelerators" {
            It "should register type accelerators" {
                # arrange
                $typeAccelerators = [ReflectionCache]::TypeAccelerators

                # act
                _registerAccelerators

                # assert
                $typeAccelerators::Get.GetEnumerator().Where( { $_.Key -eq 'GraphRequest' } ) | Should -Not -BeNullOrEmpty
            }
        }

        Context "_unregisterAccelerators" {
            It "should unregister type accelerators" {
                # arrange
                $typeAccelerators = [ReflectionCache]::TypeAccelerators

                _registerAccelerators

                # act
                _uregisterAccelerators

                # assert
                $typeAccelerators::Get.GetEnumerator().Where( { $_.Key -eq 'GraphRequest' } ) | Should -BeNullOrEmpty
            }
        }
    }
}
