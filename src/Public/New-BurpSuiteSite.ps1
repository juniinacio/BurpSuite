function New-BurpSuiteSite {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $ParentId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [psobject] $Scope,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]] $ScanConfigurationIds,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [psobject[]] $EmailRecipients,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [psobject[]] $ApplicationLogins
    )

    begin {
    }

    process {
        if (-not ($PSBoundParameters.ContainsKey('ParentId'))) { $ParentId = "0" }

        $query = _buildMutation -queryName 'CreateSite' -inputType 'CreateSiteInput!' -name 'create_site' -returnType 'Site'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.name = $Name
                $variables.input.parent_id = $ParentId

                if ($PSBoundParameters.ContainsKey('Scope')) {
                    $scopeInput = @{ included_urls = @(); excluded_urls = @() }

                    $includedUrls = _getObjectProperty -InputObject $Scope -PropertyName 'IncludedUrls'
                    if ($null -eq $includedUrls) { throw "Property 'IncludedUrls' is required when specifying scope object." }
                    $scopeInput.included_urls = @($includedUrls)

                    $excludedUrls = _getObjectProperty -InputObject $Scope -PropertyName 'ExcludedUrls'
                    if ($null -ne $excludedUrls) { $scopeInput.excluded_urls = @($excludedUrls) }

                    $variables.input.scope = $scopeInput
                }

                $variables.input.scan_configuration_ids = $ScanConfigurationIds

                if ($PSBoundParameters.ContainsKey('EmailRecipients')) {
                    $emailRecipientInput = @()

                    foreach ($emailRecipient in $EmailRecipients) {
                        $email = _getObjectProperty -InputObject $emailRecipient -PropertyName 'Email'
                        if ($null -eq $email) { throw "Property 'Email' is required when specifying email recipient objects." }
                        $emailRecipientInput += @{ email = $emailRecipient }
                    }

                    $variables.input.email_recipients = $emailRecipientInput
                }

                if ($PSBoundParameters.ContainsKey('ApplicationLogins')) {
                    $applicationLoginInput = @()

                    foreach ($applicationLogin in $ApplicationLogins) {
                        $label = _getObjectProperty -InputObject $applicationLogin -PropertyName 'Label'
                        if ($null -eq $label) { throw "Property 'Label' is required when specifying application login objects." }

                        $username = _getObjectProperty -InputObject $applicationLogin -PropertyName 'Username'
                        if ($null -eq $username) { throw "Property 'Username' is required when specifying application login objects." }

                        $password = _getObjectProperty -InputObject $applicationLogin -PropertyName 'Password'
                        if ($null -eq $password) { throw "Property 'Password' is required when specifying application login objects." }

                        $applicationLoginInput += @{ label = $label; username = $username; password = $password }
                    }

                    $variables.input.application_logins = $applicationLoginInput
                }

                $request = [Request]::new($query, 'CreateSite', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
