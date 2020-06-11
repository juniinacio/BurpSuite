class IQuery {
    IQuery() {
        $type = $this.GetType()
        if ($type -eq [IQuery]) {
            throw "Class $type must be inherited"
        }
    }

    [string] Build() { throw "Must override method" }
    [IQuery] AddArgument([string] $key, [object] $value) { throw "Must override method" }
    [IQuery] AddField([string] $field) { throw "Must override method" }
    [IQuery] AddField($query) { throw "Must override method" }
    [IQuery] AddField([string] $field, [IQuery] $query) { throw "Must override method" }

    [string] ToString() { return $this.Build() }
}
