InModuleScope BurpSuite {
    Describe "Queries" {
        Context "_buildObjectQuery" {
            It "should build AgentError object" {
                # arrange

                # act
                $assert = _buildObjectQuery -name 'error' -objectType 'AgentError'

                # assert
                "$assert" | Should -BeExactly 'error { code error }'
            }

            It "should build ApplicationLogin object" {
                # arrange

                # act
                $assert = _buildObjectQuery -name 'application_login' -objectType 'ApplicationLogin'

                # assert
                "$assert" | Should -BeExactly 'application_login { id label username }'
            }

            # It "should build AuditItem object" {
            #     # arrange

            #     # act
            #     $assert = _buildObjectQuery -name 'audit_item' -objectType 'AuditItem'

            #     # assert
            #     "$assert" | Should -BeExactly 'audit_item { id host path error_types issue_counts { total confidence severity number_of_children first_child_serial_number novelty } number_of_requests number_of_errors number_of_insertion_points }'
            # }

            It "should build CountsByConfidence object" {
                # arrange

                # act
                $assert = _buildObjectQuery -name 'counts_by_confidence' -objectType 'CountsByConfidence'

                # assert
                "$assert" | Should -BeExactly 'counts_by_confidence { total firm tentative certain }'
            }

            It "should build IssueCounts object" {
                # arrange

                # act
                $assert = _buildObjectQuery -name 'issue_counts' -objectType 'IssueCounts'

                # assert
                "$assert" | Should -BeExactly 'issue_counts { total high { total firm tentative certain } medium { total firm tentative certain } low { total firm tentative certain } info { total firm tentative certain } }'
            }

            It "should build IssueType object" {
                # arrange

                # act
                $assert = _buildObjectQuery -name 'issue_type' -objectType 'IssueType'

                # assert
                "$assert" | Should -BeExactly 'issue_type { type_index confidence severity number_of_children first_child_serial_number novelty }'
            }
        }
    }
}
