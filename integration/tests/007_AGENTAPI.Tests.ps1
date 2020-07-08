Set-StrictMode -Version Latest

##############################################################
#     THESE TEST ARE DESTRUCTIVE. USE A CLEAN BURPSUITE.     #
##############################################################
# Before running these tests you must set the following      #
# Environment variables.                                     #
# $env:BURPSUITE_APIKEY = BurpSuite Enterprise API key       #
# $env:BURPSUITE_APIVERSION = v1                             #
# $env:BURPSUITE_URL = Url to BurpSuite Enterprise           #
##############################################################
#     THESE TEST ARE DESTRUCTIVE. USE A CLEAN BURPSUITE.     #
##############################################################

Describe 'Agent API' -Tag 'CD' {
    BeforeAll {
        $BURPSUITE_APIKEY = $env:BURPSUITE_APIKEY
        $BURPSUITE_APIVERSION = $env:BURPSUITE_APIVERSION
        $BURPSUITE_URL = $env:BURPSUITE_URL

        Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL
    }

    Context 'Get-BurpSuiteAgent' {
        BeforeAll {
        }

        It 'should get agent' {
            # Arrange

            # Act
            $assert = Get-BurpSuiteAgent


            # Assert
            $assert.id | Should -Not -BeNullOrEmpty
        }

        AfterEach {
        }
    }

    Context 'Disable-BurpSuiteAgent' {
        BeforeAll {
            Get-BurpSuiteAgent | Enable-BurpSuiteAgent
        }

        It 'should disable agent' {
            # Arrange

            # Act
            Get-BurpSuiteAgent | Disable-BurpSuiteAgent

            # Assert
            Get-BurpSuiteAgent | Where-Object { $_.enabled -eq $true } | Should -Be $false
        }

        AfterAll {
            Get-BurpSuiteAgent | Enable-BurpSuiteAgent
        }
    }

    Context 'Enable-BurpSuiteAgent' {
        BeforeAll {
            Get-BurpSuiteAgent | Disable-BurpSuiteAgent
        }

        It 'should enable agent' {
            # Arrange

            # Act
            Get-BurpSuiteAgent | Enable-BurpSuiteAgent

            # Assert
            Get-BurpSuiteAgent | Where-Object { $_.enabled -eq $false } | Should -Be $false
        }

        AfterAll {
            Get-BurpSuiteAgent | Enable-BurpSuiteAgent
        }
    }

    Context 'Revoke-BurpSuiteAgent' {
        BeforeAll {
            Get-BurpSuiteUnauthorizedAgent | Grant-BurpSuiteAgent
        }

        It 'should deauthorize agent' {
            # Arrange

            # Act
            Get-BurpSuiteAgent | Revoke-BurpSuiteAgent

            # Assert
            Get-BurpSuiteUnauthorizedAgent | Where-Object {$_.ip -eq '127.0.0.1'} | Should -Not -BeNullOrEmpty
        }

        AfterEach {
            Get-BurpSuiteUnauthorizedAgent | Grant-BurpSuiteAgent
        }
    }

    Context 'Grant-BurpSuiteAgent' {
        BeforeAll {
            Get-BurpSuiteAgent | Revoke-BurpSuiteAgent
        }

        It 'should authorize agent' {
            # Arrange

            # Act
            Get-BurpSuiteAgent | Grant-BurpSuiteAgent

            # Assert
            Get-BurpSuiteUnauthorizedAgent | Should -BeNullOrEmpty
        }

        AfterEach {
            Get-BurpSuiteUnauthorizedAgent | Grant-BurpSuiteAgent
        }
    }
}
