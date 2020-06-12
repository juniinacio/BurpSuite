class GraphRequest {
    hidden [string] $Query = [string]::Empty
    hidden [hashtable] $Variables = @{}

    GraphRequest([string] $query) {
        $this.Query = $Query
    }

    GraphRequest([string] $query, [hashtable] $variables) {
        $this.Query = $Query
        $this.Variables = $Variables
    }
}
