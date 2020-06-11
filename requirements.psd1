@{
    PSDependOptions    = @{
        Target = 'CurrentUser'
    }
    'Pester'           = @{
        Version    = '5.0.2'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
    'PSScriptAnalyzer' = @{
        Version = '1.19.0'
    }
    'psake'            = @{
        Version = '4.9.0'
    }
    'BuildHelpers'     = @{
        Version = '2.0.11'
    }
    'PowerShellBuild'  = @{
        Version = '0.4.0'
    }
}
