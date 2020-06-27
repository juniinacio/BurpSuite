function Get-BurpSuiteSiteTree {
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateSet('folders', 'sites')]
        [string[]]
        $Fields
    )

    begin {
        if (-not ($PSBoundParameters.ContainsKey('Fields'))) { $Fields = 'folders', 'sites' }
    }

    process {

        $query = _buildQuery -name 'site_tree' -objectType 'SiteTree' -fields $Fields

        $request = [Request]::new($query)

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $response = _callAPI -Request $Request
                $data = _getObjectProperty -InputObject $response -PropertyName 'data'
                if ($null -ne $data) {
                    $data.site_tree
                }
            } catch {
                throw
            }
        }
    }

    end {
    }
}
