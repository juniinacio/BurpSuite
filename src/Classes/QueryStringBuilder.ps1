class QueryStringBuilder {
    hidden [System.Text.StringBuilder] $QueryString = [System.Text.StringBuilder]::new()

    QueryStringBuilder() {
    }

    [void] Clear() {
        $this.QueryString.Clear()
    }

    hidden [string] FormatQueryParam([object] $value) {
        switch ($value) {
            { $_ -is [string] } { return "`"" + $value + "`"" }
            { $_ -is [byte] } { return $value.ToString() }
            { $_ -is [sbyte] } { return $value.ToString() }
            { $_ -is [int16] } { return $value.ToString() }
            { $_ -is [uint16] } { return $value.ToString() }
            { $_ -is [int] } { return $value.ToString() }
            { $_ -is [uint64] } { return $value.ToString() }
            { $_ -is [int64] } { return $value.ToString() }
            { $_ -is [float] } { return $value.ToString([CultureInfo]::CreateSpecificCulture("en-us")) }
            { $_ -is [double] } { return $value.ToString([CultureInfo]::CreateSpecificCulture("en-us")) }
            { $_ -is [decimal] } { return $value.ToString([CultureInfo]::CreateSpecificCulture("en-us")) }
            { $_ -is [bool] } { return @{$true = "true"; $false = "false" }[$value] }
            { $_ -is [enum] } { return $value.ToString() }
            { $_ -is [KeyValuePair[string, object]] } { return "$($value.Key):$($this.FormatQueryParam($value.Value))" }
            { $_ -is [IDictionary[string, object]] } { return "{$(@($value.GetEnumerator() | ForEach-Object { $this.FormatQueryParam($_) }) -join ", ")}" }
            { $_ -is [IEnumerable] } {
                $items = [System.Collections.Generic.List[string]]::new()
                foreach ($item in $_.GetEnumerator()) {
                    $items.Add($this.FormatQueryParam($item))
                }
                return "[$($items -join ",")]"
            }
            default {
                throw ([InvalidDataException]::new("Unsupported query parameter, type found: " + $value.GetType()))
            }
        }
        throw ([InvalidDataException]::new("Unsupported query parameter, type found: " + $value.GetType()))
    }

    hidden [void] AddParams([IQuery] $query) {
        foreach ($param in $query.Arguments.GetEnumerator()) {
            $this.QueryString.Append("$($param.Key):$($this.FormatQueryParam($param.Value)),")
        }

        if ($query.Arguments.Count -gt 0) { $this.QueryString.Length-- }
    }

    hidden [void] AddFields([IQuery] $query) {
        foreach ($item in $query.Fields.GetEnumerator()) {
            switch ($item) {
                { $_ -is [string] } { $this.QueryString.Append("$item ") }
                { $_ -is [IQuery] } { $this.QueryString.Append("$($item.Build()) ") }
                default {
                    throw ([ArgumentException]::new("Invalid field type specified, must be 'string' or 'Query'"))
                }
            }
        }
    }

    [string] Build([IQuery] $query) {
        if (![string]::IsNullOrEmpty($query.AliasName)) { $this.QueryString.Append("$($query.AliasName):") }

        $this.QueryString.Append($query.Name)

        if ($query.Arguments.Count -gt 0) {
            $this.QueryString.Append("(")
            $this.AddParams($query)
            $this.QueryString.Append(")")
        }

        if ($query.Fields.Count -gt 0) {
            $this.QueryString.Append(" { ")
            $this.AddFields($query)
            $this.QueryString.Append(" }")
        } else { $this.AddFields($query) }

        return $this.QueryString.ToString()
    }
}

