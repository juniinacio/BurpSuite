InModuleScope $env:BHProjectName {
    Describe "Disconnect-BurpSuite" {
        Context "Session" {
            It "should disposes session on error" {
                # arrange
                Mock -CommandName _removeSession

                # act
                Disconnect-BurpSuite

                # assert
                Should -Invoke _removeSession
            }
        }
    }
}
