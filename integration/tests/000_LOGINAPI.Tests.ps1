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

InModuleScope BurpSuite {
    Describe 'Login API' -Tag 'CD' {
        BeforeAll {
            $BURPSUITE_APIKEY = $env:BURPSUITE_APIKEY
            $BURPSUITE_APIVERSION = $env:BURPSUITE_APIVERSION
            $BURPSUITE_URL = $env:BURPSUITE_URL
        }

        Context 'Connect-BurpSuite' {
            It 'should connect to BurpSuite' {
                # Arrange

                # Act
                $assert = Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL -PassThru

                # Assert
                $assert.__schema | Should -Not -BeNullOrEmpty
            }
        }

        Context 'Disconnect-BurpSuite' {
            It 'should disconnect from BurpSuite' {
                # Arrange

                # Act

                # Assert
                { Disconnect-BurpSuite} | Should -Not -Throw
            }
        }
    }
}
