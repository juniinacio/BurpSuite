InModuleScope $env:BHProjectName {
    Describe "New-BurpSuiteScheduleItem" {
        It "should create schedule item" {
            # arrange
            $siteId = 1
            $scanConfigurationIds = 1, 2, 3

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        create_schedule_item = [PSCustomObject]@{
                            schedule_item = [PSCustomObject]@{
                                id = 1
                            }
                        }
                    }
                }
            }

            # act
            New-BurpSuiteScheduleItem -SiteId $siteId -ScanConfigurationIds $scanConfigurationIds

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateScheduleItem" `
                    -and $Request.Query -eq 'mutation CreateScheduleItem($input:CreateScheduleItemInput!) { create_schedule_item(input:$input) { schedule_item { id } } }' `
                    -and $Request.Variables.input.site_id -eq $siteId `
                    -and ($Request.Variables.input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',')
            }
        }

        It "should create schedule item with initial run time" {
            # arrange
            $siteId = 1
            $scanConfigurationIds = '2d83ee78-3a5f-401d-b745-a7b36660ebbe', '388b2cf5-542c-4c66-a8f4-705bf9b1ae23'
            $initialRunTime = '2020-06-19T08:30:41'

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_item = [PSCustomObject]@{
                            id = $siteId
                        }
                    }
                }
            }

            # act
            New-BurpSuiteScheduleItem -SiteId $siteId -ScanConfigurationIds $scanConfigurationIds -InitialRunTime $initialRunTime

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateScheduleItem" `
                    -and $Request.Query -eq 'mutation CreateScheduleItem($input:CreateScheduleItemInput!) { create_schedule_item(input:$input) { schedule_item { id } } }' `
                    -and $Request.Variables.input.site_id -eq $siteId `
                    -and ($Request.Variables.input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',') `
                    -and $Request.Variables.input.schedule.initial_run_time -eq $initialRunTime
            }
        }

        It "should create schedule item with recurrence rule" {
            # arrange
            $siteId = 1
            $scanConfigurationIds = '2d83ee78-3a5f-401d-b745-a7b36660ebbe', '388b2cf5-542c-4c66-a8f4-705bf9b1ae23'
            $recurrenceRule = 'FREQ=DAILY;INTERVAL=1'

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_item = [PSCustomObject]@{
                            id = $siteId
                        }
                    }
                }
            }

            # act
            New-BurpSuiteScheduleItem -SiteId $siteId -ScanConfigurationIds $scanConfigurationIds -RecurrenceRule $recurrenceRule

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "CreateScheduleItem" `
                    -and $Request.Query -eq 'mutation CreateScheduleItem($input:CreateScheduleItemInput!) { create_schedule_item(input:$input) { schedule_item { id } } }' `
                    -and $Request.Variables.input.site_id -eq $siteId `
                    -and $Request.Variables.input.schedule.rrule -eq $recurrenceRule `
                    -and ($Request.Variables.input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',')
            }
        }
    }
}
