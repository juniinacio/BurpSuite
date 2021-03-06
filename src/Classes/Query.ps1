class Query {
    [string] $Name
    [string] $AliasName
    [Dictionary[string, object]] $Arguments = [Dictionary[string, object]]::new()
    [List[object]] $Fields = [List[object]]::new()

    hidden [QueryStringBuilder] $QueryStringBuilder = [QueryStringBuilder]::new()

    Query([String] $newName) {
        $this.Name = $newName
    }

    [void] SetAlias([string] $alias) {
        $this.AliasName = $alias
    }

    [string] Build() {
        $this.QueryStringBuilder.Clear()
        return $this.QueryStringBuilder.Build($this)
    }

    [void] AddArgument([string] $key, [object] $value) {
        $this.Arguments.Add($key, $value)
    }

    [void] AddField([object] $field) {
        $this.Fields.Add($field)
    }

    [void] AddFields([object[]] $fields) {
        foreach ($field in $fields) { $this.Fields.Add($field) }
    }

    [string] ToString() { return $this.Build() }
}

