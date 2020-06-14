Set-StrictMode -Version Latest

# if ($null -eq $env:TEAM_CIBUILD) {
#    Get-Module Barracuda.WAF | Remove-Module -Force
#    Import-Module $PSScriptRoot\..\..\dist\Barracuda.WAF.psd1 -Force
# }

##############################################################
#     THESE TEST ARE DESTRUCTIVE. USE A CLEAN WAF.           #
##############################################################
# Before running these tests you must set the following      #
# Environment variables.                                     #
# $env:BWAF_VERSION = 3, 3.1                                 #
#                    depending on your Barracuda WAF         #
# $env:BWAF_URI = Url to your Barracuda WAF                  #
#             collection                                     #
# $env:BWAF_PASSWORD = password for your Barracuda WAF       #
# $env:EMAIL = Email of user to activate the WAF             #
##############################################################
#     THESE TEST ARE DESTRUCTIVE. USE A CLEAN WAF.           #
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
                { Connect-BurpSuite -APIKey $BURPSUITE_APIKEY -Uri $BURPSUITE_URL } | Should -Not -Throw

                # Assert
            }
        }

        Context 'Disconnect-BurpSuite' {
            It 'should disconnect from BurpSuite' {
                # Arrange

                # Act

                # Assert
            }
        }
    }
}
