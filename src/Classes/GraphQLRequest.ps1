class GraphQLRequest {
    hidden [string] $Query = [string]::Empty
    hidden [hashtable] $Variables = @{}

    GraphQLRequest([string] $query) {
        $this.Query = $Query
    }

    GraphQLRequest([string] $query, [hashtable] $variables) {
        $this.Query = $Query
        $this.Variables = $Variables
    }
}
