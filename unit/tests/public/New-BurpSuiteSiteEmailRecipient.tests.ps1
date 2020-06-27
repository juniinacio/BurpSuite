InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteSiteEmailRecipient" {
        It "should create site email recipient" {
            # arrange
            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        create_site_email_recipient = [PSCustomObject]@{
                            email_recipient = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            New-BurpSuiteSiteEmailRecipient -SiteId 42 -EmailRecipient "mail@example.com"

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateSiteEmailRecipient" `
                    -and $Request.Query -eq 'mutation CreateSiteEmailRecipient($input:''CreateSiteEmailRecipientInput!'') { create_site_email_recipient(input:''$input'') { email_recipient { id email } } }' `
                    -and $Request.Variables.Input.site_id -eq 42 `
                    -and $Request.Variables.Input.email_recipient.email -eq "mail@example.com"
            }
        }
    }
}
