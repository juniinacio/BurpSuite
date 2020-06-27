InModuleScope $env:BHProjectName {
    Describe "Update-BurpSuiteSiteEmailRecipient" {
        It "should update site email recipient" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_site_email_recipient = [PSCustomObject]@{
                            email_recipient = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            Update-BurpSuiteSiteEmailRecipient -Id 42 -Email "mail@example.com"

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateSiteEmailRecipient" `
                    -and $Request.Query -eq 'mutation UpdateSiteEmailRecipient($input:''UpdateSiteEmailRecipientInput!'') { update_site_email_recipient(input:''$input'') { email_recipient { id email } } }' `
                    -and $Request.Variables.Input.id -eq 42 `
                    -and $Request.Variables.Input.email -eq "mail@example.com"
            }
        }
    }
}
