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
        [string[]] $IncludedUrls,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [AllowEmptyCollection()]
        [string[]] $ExcludedUrls,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]] $ScanConfigurationIds,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]] $EmailRecipients

        # [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        # [ValidateNotNullOrEmpty()]
        # [hashtable[]] $ApplicationLogins
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

                if ($PSBoundParameters.ContainsKey('IncludedUrls') -or $PSBoundParameters.ContainsKey('ExcludedUrls')) {
                    $scope = @{ included_urls = @(); excluded_urls = @() }
                    $scope.included_urls = $IncludedUrls
                    if ($PSBoundParameters.ContainsKey('ExcludedUrls')) { $scope.excluded_urls = $ExcludedUrls }
                    $variables.input.scope = $scope
                }

                # if ($PSBoundParameters.ContainsKey('ApplicationLogins')) {
                #     $variables.input.application_logins = $ApplicationLogins
                # }
                $variables.input.application_logins = @()

                $variables.input.scan_configuration_ids = $ScanConfigurationIds

                if ($PSBoundParameters.ContainsKey('EmailRecipients')) {
                    $variables.input.email_recipients = @($EmailRecipients.ForEach( { [PSCustomObject]@{email = $_ } }))
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
