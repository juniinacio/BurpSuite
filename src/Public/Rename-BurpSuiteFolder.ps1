function Rename-BurpSuiteFolder {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Name
    )

    begin {
    }

    process {

        $query = _buildMutation -queryName 'RenameFolder' -inputType 'RenameFolderInput!' -name 'rename_folder' -returnType 'Folder'

        if ($PSCmdlet.ShouldProcess("BurpSuite", $query)) {
            try {
                $variables = @{ input = @{} }
                $variables.input.name = $Name
                $variables.input.id = $Id

                $request = [Request]::new($query, 'RenameFolder', $variables)

                $null = _callAPI -Request $request
            } catch {
                throw
            }
        }
    }

    end {
    }
}
