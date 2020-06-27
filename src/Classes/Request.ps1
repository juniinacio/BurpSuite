class Request {
    [string] $Query = [string]::Empty
    [string] $OperationName = [string]::Empty
    [hashtable] $Variables = @{}

    Request() {
    }

    Request([string] $query) {
        $this.Query = $Query
    }

    Request([string] $query, [string] $operationName) {
        $this.Query = $Query
        $this.OperationName = $operationName
    }

    Request([string] $query, [hashtable] $variables) {
        $this.Query = $Query
        $this.Variables = $Variables
    }

    Request([string] $query, [string] $operationName, [hashtable] $variables) {
        $this.Query = $Query
        $this.OperationName = $operationName
        $this.Variables = $Variables
    }
}

