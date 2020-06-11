class Session {
    static [string] $APIKey
    static [string] $APIUrl

    static [void] Create([string] $APIKey, [string] $APIUrl) {
        [Session]::APIKey = $APIKey
        [Session]::APIUrl = $APIUrl
    }

    static [void] Dispose() {
        [Session]::APIKey = $null
        [Session]::APIUrl = $null
    }
}
