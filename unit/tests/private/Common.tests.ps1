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

                [Session]::Dispose()
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

                [Session]::Dispose()
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

                [Session]::Dispose()
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

                [Session]::Dispose()
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

                [Session]::Dispose()
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

                [Session]::Dispose()
            }

            if ((_testIsPowerShellCore)) {
                It 'should set skip certificate checks' {
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
                        $SkipCertificateCheck -eq $true
                    }

                    [Session]::Dispose()
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
                $typeAccelerators::Get.GetEnumerator().Where( { $_.Key -eq 'BurpSuiteGraphRequest' } ) | Should -Not -BeNullOrEmpty
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
                $typeAccelerators::Get.GetEnumerator().Where( { $_.Key -eq 'BurpSuiteGraphRequest' } ) | Should -BeNullOrEmpty
            }
        }

        Context '_getPowerShellVersion' {
            It 'should output the correct version' {
                # Arrange

                # Act
                $assert = _getPowerShellVersion

                # Assert
                $assert | Should -BeExactly $PSVersionTable.PSVersion
            }
        }

        Context '_testIsPowerShellCore' {
            It 'should output false' {
                # Arrange
                Mock _getPowerShellVersion -MockWith {
                    [version]"5.1"
                }

                # Act
                $assert = _testIsPowerShellCore

                # Assert
                $assert | Should -Be $false
            }

            It 'should output true' {
                # Arrange
                Mock _getPowerShellVersion -MockWith {
                    [version]"6.0"
                }

                # Act
                $assert = _testIsPowerShellCore

                # Assert
                $assert | Should -Be $true
            }
        }

        Context '_preProcessRequest' {
            It 'should convert object properties names to lower case' {
                # Arrange
                $request = [GraphRequest]::new('{ __schema { queryType { name } } }')

                # Act
                $assert = _preProcessRequest -GraphRequest $request

                # Assert
                $assert | Get-Member -MemberType Properties | Where-Object {$_.Name -cmatch "[A-Z]+"} | Should -BeNullOrEmpty
            }

            It 'should keep object properties' {
                # Arrange
                $request = [GraphRequest]::new('{ __schema { queryType { name } } }', '__schema')

                # Act
                $assert = _preProcessRequest -GraphRequest $request

                # Assert
                $assert | Get-Member -MemberType Properties | Where-Object {$_.Name -eq "query"} | Should -Not -BeNullOrEmpty
                $assert | Get-Member -MemberType Properties | Where-Object {$_.Name -eq "operationname"} | Should -Not -BeNullOrEmpty
            }

            It 'should remove object properties' {
                # Arrange
                $request = [GraphRequest]::new('{ __schema { queryType { name } } }', '__schema')

                # Act
                $assert = _preProcessRequest -GraphRequest $request

                # Assert
                $assert | Get-Member -MemberType Properties | Where-Object {$_.Name -eq "variables"} | Should -BeNullOrEmpty
            }
        }
    }
}
