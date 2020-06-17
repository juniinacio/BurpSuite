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
    }

    process {

        $graphRequest = _buildSuiteSiteTreeQuery -Parameters $PSBoundParameters

        if ($PSCmdlet.ShouldProcess("BurpSuite", $graphRequest.Query)) {
            try {
                $response = _callAPI -GraphRequest $graphRequest
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
