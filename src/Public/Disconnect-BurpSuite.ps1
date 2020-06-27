function Disconnect-BurpSuite {
    [CmdletBinding()]
    Param (
    )

    begin {
    }

    process {
        _removeSession
    }

    end {
    }
}
