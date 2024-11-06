properties {
    $projectRoot = $ENV:BHProjectPath
    if (-not $projectRoot) {
        $projectRoot = $PSScriptRoot
    }

    $srcRootDir = Join-Path -Path $projectRoot -ChildPath 'src'

    $manifest = Import-PowerShellDataFile -Path $env:BHPSModuleManifest

    $outputDir = Join-Path -Path $projectRoot -ChildPath '.out'
    $outputModDir = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
    $outputModVerDir = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion

    $PSBPreference.General.SrcRootDir = $srcRootDir

    $PSBPreference.Build.OutDir = $outputDir
    $PSBPreference.Build.ModuleOutDir = $outputModVerDir
    $PSBPreference.Build.CompileModule = $true

    $PSBPreference.Help.DefaultLocale = 'en-US'

    if (-not (Get-Module -Name Pester)) { Import-Module -Name Pester -ErrorAction Stop }

    $PesterPreference = [PesterConfiguration]::Default
    $PesterPreference.Run.Path = Join-Path -Path $projectRoot -ChildPath 'unit\tests\*\*.Tests.ps1'
    $PesterPreference.Run.PassThru = $true
    $PesterPreference.TestResult.Enabled = $true
    $PesterPreference.TestResult.OutputPath = Join-Path -Path $outputDir -ChildPath "$($env:BHProjectName)-TestsResults.xml"
    $PesterPreference.CodeCoverage.Enabled = $true
    $PesterPreference.CodeCoverage.Path = Join-Path -Path $outputModVerDir -ChildPath '*.psm1'
    $PesterPreference.CodeCoverage.OutputPath = Join-Path -Path $outputDir -ChildPath "$($env:BHProjectName)-Coverage.xml"
    $PesterPreference.Output.Verbosity = "Detailed"
}

task default -depends RunTest

task Analyze -FromModule PowerShellBuild -Version '0.4.0'

$invokePesterPreReqs = {
    $result = $true
    if (-not $PesterPreference.TestResult.Enabled) {
        Write-Warning 'Pester testing is not enabled.'
        $result = $false
    }
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        Write-Warning 'Pester module is not installed'
        $result = $false
    }
    return $result
}
task InvokePester -depends Build -precondition $invokePesterPreReqs {
    if (-not (Get-Module -Name Pester)) {
        Import-Module -Name Pester -ErrorAction Stop
    }

    try {
        $pathSeperator = [IO.Path]::PathSeparator

        $origModulePath = $env:PSModulePath
        if ($env:PSModulePath.split($pathSeperator) -notcontains $outputDir) {
            $env:PSModulePath = ($outputDir + $pathSeperator + $origModulePath)
        }

        Remove-Module $PSBPreference.General.ModuleName -ErrorAction SilentlyContinue
        Import-Module -Name $PSBPreference.General.ModuleName -Force

        $testResults = Invoke-Pester -Configuration $PesterPreference
        Write-Host 'Pester results:' -ForegroundColor Yellow
        $tableProperties = 'Result', 'FailedCount', 'FailedBlocksCount', 'FailedContainersCount', 'PassedCount', 'SkippedCount', 'NotRunCount', 'TotalCount', 'Duration'
        $testResults | Format-Table -AutoSize -Property $tableProperties

        if ($testResults.FailedCount -gt 0) {
            throw 'One or more Pester tests failed'
        }
    } finally {
        Pop-Location
        $env:PSModulePath = $origModulePath
        Remove-Module $PSBPreference.General.ModuleName -ErrorAction SilentlyContinue
    }
} -description 'Execute Pester tests'

task RunTest -depends InvokePester, Analyze {
} -description 'Execute Pester and ScriptAnalyzer tests'
