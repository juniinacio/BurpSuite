class Query: IQuery {
    [string] $Name
    [string] $AliasName
    [Dictionary[string, object]] $Arguments = [Dictionary[string, object]]::new()
    [List[object]] $Fields = [List[object]]::new()

    hidden [QueryStringBuilder] $QueryStringBuilder = [QueryStringBuilder]::new()

    Query([String] $newName) {
        $this.Name = $newName
    }

    [Query] Alias([string] $alias) {
        $this.AliasName = $alias
        return $this
    }

    [string] Build() {
        $this.QueryStringBuilder.Clear()
        return $this.QueryStringBuilder.Build($this)
    }

    [Query] AddArgument([string] $key, [object] $value) {
        $this.Arguments.Add($key, $value)
        return $this
    }

    [Query] AddField([string] $field) {
        $this.Fields.Add($field)
        return $this
    }

    [Query] AddField($query) {
        $this.Fields.Add($query)
        return $this
    }

    [Query] AddField([string] $field, [Query] $query) {
        $subQuery = [Query]::New($field)
        $subQuery.AddField($query)
        $this.Fields.Add($subQuery)
        return $this
    }
}
