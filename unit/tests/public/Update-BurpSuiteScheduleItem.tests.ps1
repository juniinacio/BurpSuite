InModuleScope $env:BHProjectName {
    Describe "Update-BurpSuiteScheduleItem" {
        It "should update schedule item" {
            # arrange
            $id = 1
            $scanConfigurationIds = 1, 2, 3

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_schedule_item = [PSCustomObject]@{
                            schedule_item = [PSCustomObject]@{
                                id = $id
                            }
                        }
                    }
                }
            }

            # act
            Update-BurpSuiteScheduleItem -Id $id -ScanConfigurationIds $scanConfigurationIds

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateScheduleItem" `
                    -and $Request.Query -eq 'mutation UpdateScheduleItem($input:UpdateScheduleItemInput!) { update_schedule_item(input:$input) { schedule_item { id } } }' `
                    -and $Request.Variables.input.id -eq $id `
                    -and ($Request.Variables.input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',')
            }
        }

        It "should update schedule item with site id" {
            # arrange
            $id = 1
            $siteId = 1
            $scanConfigurationIds = 1, 2, 3

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        update_schedule_item = [PSCustomObject]@{
                            schedule_item = [PSCustomObject]@{
                                id = $id
                            }
                        }
                    }
                }
            }

            # act
            Update-BurpSuiteScheduleItem -Id $id -SiteId $siteId -ScanConfigurationIds $scanConfigurationIds

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateScheduleItem" `
                    -and $Request.Query -eq 'mutation UpdateScheduleItem($input:UpdateScheduleItemInput!) { update_schedule_item(input:$input) { schedule_item { id } } }' `
                    -and $Request.Variables.input.id -eq $id `
                    -and $Request.Variables.input.site_id -eq $id `
                    -and ($Request.Variables.input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',')
            }
        }

        It "should update schedule item with initial run time" {
            # arrange
            $id = 1
            $scanConfigurationIds = '2d83ee78-3a5f-401d-b745-a7b36660ebbe', '388b2cf5-542c-4c66-a8f4-705bf9b1ae23'
            $initialRunTime = '2020-06-19T08:30:41'

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_item = [PSCustomObject]@{
                            id = $id
                        }
                    }
                }
            }

            $schedule = [PSCustomObject]@{
                InitialRunTime = $initialRunTime
            }

            # act
            Update-BurpSuiteScheduleItem -Id $id -ScanConfigurationIds $scanConfigurationIds -Schedule $schedule

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateScheduleItem" `
                    -and $Request.Query -eq 'mutation UpdateScheduleItem($input:UpdateScheduleItemInput!) { update_schedule_item(input:$input) { schedule_item { id } } }' `
                    -and $Request.Variables.input.id -eq $id `
                    -and ($Request.Variables.input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',') `
                    -and $Request.Variables.input.schedule.initial_run_time -eq $initialRunTime `
                    -and $Request.Variables.input.schedule.initial_run_time_is_set -eq "true"
            }
        }

        It "should update schedule item with recurrence rule" {
            # arrange
            $id = 1
            $scanConfigurationIds = '2d83ee78-3a5f-401d-b745-a7b36660ebbe', '388b2cf5-542c-4c66-a8f4-705bf9b1ae23'
            $recurrenceRule = 'FREQ=DAILY;INTERVAL=1'

            Mock -CommandName _callAPI -MockWith {
                [PSCustomObject]@{
                    data = [PSCustomObject]@{
                        schedule_item = [PSCustomObject]@{
                            id = $id
                        }
                    }
                }
            }

            $schedule = [PSCustomObject]@{
                RRule = $RecurrenceRule
            }

            # act
            Update-BurpSuiteScheduleItem -Id $id -ScanConfigurationIds $scanConfigurationIds -Schedule $schedule

            # assert
            Should -Invoke _callAPI -ParameterFilter {
                $Request.OperationName -eq "UpdateScheduleItem" `
                    -and $Request.Query -eq 'mutation UpdateScheduleItem($input:UpdateScheduleItemInput!) { update_schedule_item(input:$input) { schedule_item { id } } }' `
                    -and $Request.Variables.input.id -eq $id `
                    -and $Request.Variables.input.schedule.rrule -eq $recurrenceRule `
                    -and $Request.Variables.input.schedule.rrule_is_set -eq "true" `
                    -and ($Request.Variables.input.scan_configuration_ids -join ',') -eq ($scanConfigurationIds -join ',')
            }
        }
    }
}
