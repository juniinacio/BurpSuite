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

    Context 'Disable-BurpSuiteAgent' {
        BeforeAll {
            Get-BurpSuiteAgent | Enable-BurpSuiteAgent
        }

        It 'should disable agent' {
            # Arrange

            # Act
            Get-BurpSuiteAgent | Disable-BurpSuiteAgent
            Start-Sleep -Seconds 1

            # Assert
            Get-BurpSuiteAgent | Where-Object { $_.enabled -eq $true } | Should -BeNullOrEmpty
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
            Start-Sleep -Seconds 1

            # Assert
            Get-BurpSuiteAgent | Where-Object { $_.enabled -eq $false } | Should -BeNullOrEmpty
        }

        AfterAll {
            Get-BurpSuiteAgent | Enable-BurpSuiteAgent
        }
    }

    # Context 'Revoke-BurpSuiteAgent' {
    #     BeforeAll {
    #         Get-BurpSuiteUnauthorizedAgent -Fields ip, machine_id | Grant-BurpSuiteAgent
    #         Start-Sleep -Seconds 1
    #     }

    #     It 'should deauthorize agent' {
    #         # Arrange

    #         # Act
    #         Get-BurpSuiteAgent | Revoke-BurpSuiteAgent
    #         Start-Sleep -Seconds 5

    #         # Assert
    #         Get-BurpSuiteUnauthorizedAgent -Fields ip, machine_id | Should -Not -BeNullOrEmpty
    #     }

    #     AfterEach {
    #         Get-BurpSuiteUnauthorizedAgent -Fields ip, machine_id | Grant-BurpSuiteAgent
    #         Start-Sleep -Seconds 1
    #     }
    # }

    # Context 'Grant-BurpSuiteAgent' {
    #     BeforeAll {
    #         Get-BurpSuiteAgent | Revoke-BurpSuiteAgent
    #         Start-Sleep -Seconds 1
    #     }

    #     It 'should authorize agent' {
    #         # Arrange

    #         # Act
    #         Get-BurpSuiteAgent | Grant-BurpSuiteAgent
    #         Start-Sleep -Seconds 5

    #         # Assert
    #         Get-BurpSuiteUnauthorizedAgent | Should -BeNullOrEmpty
    #     }

    #     AfterEach {
    #         Get-BurpSuiteUnauthorizedAgent -Fields ip, machine_id | Grant-BurpSuiteAgent
    #         Start-Sleep -Seconds 1
    #     }
    # }
}
