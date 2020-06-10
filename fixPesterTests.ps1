param ($Path = '.')

# version 2017-12-13

$testFiles = $(Get-ChildItem -Path $Path -Recurse *.Tests.ps1).FullName

function Get-FileEncoding {
    # source https://gist.github.com/jpoehls/2406504
    # simplified.

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [string]$Path
    )

    [byte[]]$byte = get-content -Encoding byte -ReadCount 4 -TotalCount 4 -Path $Path

    if ( $byte[0] -eq 0xef -and $byte[1] -eq 0xbb -and $byte[2] -eq 0xbf )
    { Write-Output 'UTF8' }

    else
    { Write-Output 'ASCII' }
}

foreach ($file in $testFiles)
{
    "Migrating '$file'"
    $encoding = Get-FileEncoding -Path $file
    $content = Get-Content -Path $file -Encoding $encoding
    $content = $content -replace 'Should\s+\-?Contain', 'Should -FileContentMatch'
    $content = $content -replace 'Should\s+\-?Not\s*-?Contain', 'Should -Not -FileContentMatch'
    $content = $content -replace 'Assert-VerifiableMocks', 'Assert-VerifiableMock'
    $content | Set-Content -Path $file -Encoding $encoding
}
