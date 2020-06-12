InModuleScope $env:BHProjectName {
    Describe "Connect-BurpSuite" {
        Context "Validation" {
            It "should validate API key by calling BurpSuite" {
                # arrange
                Mock -CommandName _callAPI

                # act
                Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"

                # assert
                Should -Invoke _callAPI -ParameterFilter {
                    $GraphRequest.query -eq "{ __schema { queryType { name } } }"
                }
            }

            It "should throw exception when API key is not valid" {
                # arrange
                $apiKey = "d0D99S3Strkcdd8oALICjmPtwJuLbFtKX"

                Mock -CommandName _callAPI -MockWith {
                    throw "Invalid key exception"
                }

                # act

                # assert
                { Connect-BurpSuite -APIKey $apiKey -Uri "https://burpsuite.example.org" } | Should -Throw -ExpectedMessage "*$apiKey*"
            }
        }

        Context "Session" {
            It "should create new session" {
                # arrange
                Mock -CommandName _createSession
                Mock -CommandName _callAPI

                # act
                Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"

                # assert
                Should -Invoke _createSession -ParameterFilter {
                    $APIUrl -eq 'https://burpsuite.example.org:443/graphql/v1' `
                        -and $APIKey -eq 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX'
                }
            }

            It "should disposes session on error" {
                # arrange
                Mock -CommandName _removeSession
                Mock -CommandName _callAPI -MockWith {
                    throw "Invalid key exception"
                }

                # act
                try {
                    Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"
                } catch {
                }

                # assert
                Should -Invoke _removeSession
            }
        }
    }
}
