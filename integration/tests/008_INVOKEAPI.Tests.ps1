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

    Context 'Invoke-BurpSuiteAPI' {
        BeforeAll {
            Get-BurpSuiteAgent | Enable-BurpSuiteAgent
        }

        It 'should support accelerators' {
            # Arrange
            $graphRequest = [BurpSuiteRequest]::new('query GetAgents { agents { id name state enabled } }')

            # Act
            $agents = Invoke-BurpSuiteAPI -Request $graphRequest -Confirm:$false

            # Assert
            $agents | Should -Not -BeNullOrEmpty
            $agents.data | Should -Not -BeNullOrEmpty
            $agents.data.agents | Should -Not -BeNullOrEmpty
        }

        It 'should support free form queries' {
            # Arrange

            # Act
            $agents = Invoke-BurpSuiteAPI -Query 'query GetAgents { agents { id name state enabled } }' -Confirm:$false

            # Assert
            $agents | Should -Not -BeNullOrEmpty
            $agents.data | Should -Not -BeNullOrEmpty
            $agents.data.agents | Should -Not -BeNullOrEmpty
        }

        AfterAll {
        }
    }
}
