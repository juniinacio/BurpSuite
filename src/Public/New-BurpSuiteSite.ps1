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
        [Alias('ApplicationLogins')]
        [psobject[]] $LoginCredentials,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [psobject[]] $RecordedLogins
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
                        $emailRecipientInput += @{ email = $email }
                    }

                    $variables.input.email_recipients = $emailRecipientInput
                }

                $applicationLoginInput = @{}
                $applicationLoginInput.login_credentials = @()
                $applicationLoginInput.recorded_logins = @()

                if ($PSBoundParameters.ContainsKey('LoginCredentials')) {
                    foreach ($loginCredential in $LoginCredentials) {
                        $label = _getObjectProperty -InputObject $loginCredential -PropertyName 'Label'
                        if ($null -eq $label) { throw "Property 'Label' is required when specifying login credential objects." }

                        $credential = _getObjectProperty -InputObject $loginCredential -PropertyName 'Credential'
                        if ($null -eq $credential) { throw "Property 'Credential' is required when specifying login credential objects." }

                        $networkCredential = $credential.GetNetworkCredential()

                        $applicationLoginInput.login_credentials += @{ label = $label; username = $networkCredential.UserName; password = $networkCredential.Password }
                    }
                }

                if ($PSBoundParameters.ContainsKey('RecordedLogins')) {
                    foreach ($recordedLogin in $RecordedLogins) {
                        $label = _getObjectProperty -InputObject $recordedLogin -PropertyName 'Label'
                        if ($null -eq $label) { throw "Property 'Label' is required when specifying recorded login objects." }

                        $filePath = _getObjectProperty -InputObject $recordedLogin -PropertyName 'FilePath'
                        if ($null -eq $filePath) { throw "Property 'FilePath' is required when specifying recorded login objects." }

                        $applicationLoginInput.recorded_logins += @{ label = $label; script = Get-Content -Raw -Path $filePath | Out-String }
                    }
                }

                $variables.input.application_logins = $applicationLoginInput

                $request = [Request]::new($query, 'CreateSite', $variables)

                $response = _callAPI -Request $request
                $response.data.create_site.site
            } catch {
                throw
            }
        }
    }

    end {
    }
}
