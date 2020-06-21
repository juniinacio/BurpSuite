InModuleScope $env:BHProjectName {
    Describe "Remove-BurpSuiteSiteEmailRecipient" {
        It "should remove site email recipient" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        delete_site_email_recipient = [PSCustomObject]@{
                            id = 1
                        }
                    }
                }
            }

            # act
            Remove-BurpSuiteSiteEmailRecipient -Id 42

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "DeleteSiteEmailRecipient" `
                    -and $Request.Query -eq 'mutation DeleteSiteEmailRecipient($input:''DeleteSiteEmailRecipientInput!'') { delete_site_email_recipient(input:''$input'') { id } }' `
                    -and $Request.Variables.Input.id -eq 42
            }
        }
    }
}
