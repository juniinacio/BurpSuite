function Move-BurpSuiteFolder {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $FolderId,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $ParentId
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'MoveFolder' -inputType 'MoveFolderInput!' -name 'move_folder' -returnType 'Folder'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.folder_id = $FolderId
                $variables.input.parent_id = $ParentId

                $request = [Request]::new($query, 'MoveFolder', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
