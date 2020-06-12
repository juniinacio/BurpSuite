class GraphRequest {
    [string] $Query = [string]::Empty
    [string] $OperationName = [string]::Empty
    [hashtable] $Variables = @{}

    GraphRequest([string] $query) {
        $this.Query = $Query
    }

    GraphRequest([string] $query, [string] $operationName) {
        $this.Query = $Query
        $this.OperationName = $operationName
    }

    GraphRequest([string] $query, [hashtable] $variables) {
        $this.Query = $Query
        $this.Variables = $Variables
    }

    GraphRequest([string] $query, [string] $operationName, [hashtable] $variables) {
        $this.Query = $Query
        $this.OperationName = $operationName
        $this.Variables = $Variables
    }
}

