$outputDir       = Join-Path -Path $ENV:BHProjectPath -ChildPath '.out'
$outputModDir    = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
$manifest        = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
$outputModVerDir = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion

Import-Module -Name (Join-Path -Path $outputModVerDir -ChildPath "$($env:BHProjectName).psd1") -ErrorAction Stop
InModuleScope $env:BHProjectName {
    Describe "Connect-BurpSuite" {
        It "uses the correct Uri" {
            # arrange
            Mock -CommandName Invoke-RestMethod

            # act
            Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"

            # assert
            Should -Invoke Invoke-RestMethod -ParameterFilter {
                $Uri -eq 'https://burpsuite.example.org/graphql/v1'
            }

            Assert-MockCalled -CommandName Invoke-RestMethod
        }

        It "uses the correct method" {
            # arrange
            Mock -CommandName Invoke-RestMethod

            # act
            Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"

            # assert
            Should -Invoke Invoke-RestMethod -ParameterFilter {
                $Method -eq 'Post'
            }
        }

        It "sets the correct headers" {
            # arrange
            Mock -CommandName Invoke-RestMethod

            # act
            Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"

            # assert
            Should -Invoke Invoke-RestMethod -ParameterFilter {
                $Headers.Authorization -eq 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' `
                -and $Headers.Accept -eq 'application/json' `
                -and $Headers.'Content-Type' -eq 'application/json' `
            }
        }

        It "sets the correct body" {
            # arrange
            Mock -CommandName Invoke-RestMethod

            # act
            Connect-BurpSuite -APIKey 'd0D99S3Strkcdd8oALICjmPtwJuLbFtKX' -Uri "https://burpsuite.example.org"

            # assert
            Should -Invoke Invoke-RestMethod -ParameterFilter {
                $Body -like '{"query":"*"}'
            }
        }
    }
}
