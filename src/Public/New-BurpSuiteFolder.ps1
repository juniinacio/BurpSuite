function New-BurpSuiteFolder {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $ParentId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Name
    )

    begin {
    }

    process {
        if (-not ($PSBoundParameters.ContainsKey('ParentId'))) { $ParentId = "0" }

        $query = _buildMutation -queryName 'CreateFolder' -inputType 'CreateFolderInput!' -name 'create_folder' -returnType 'Folder'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.name = $Name
                $variables.input.parent_id = $ParentId

                $request = [Request]::new($query, 'CreateFolder', $variables)

                $response = _callAPI -Request $request
                $response.data.create_folder.folder
            } catch {
                throw
            }
        }
    }

    end {
    }
}
