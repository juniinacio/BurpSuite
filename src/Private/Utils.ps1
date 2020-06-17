function _testObjectProperty {
    param(
        [object] $InputObject,
        [string] $PropertyName
    )

    return ((@($InputObject.PSObject.Properties.Match($PropertyName)).Count -gt 0) -and ($null -ne $InputObject.$PropertyName))
}

function _getObjectProperty {
    param(
        [object] $InputObject,
        [string] $PropertyName
    )

    if ((_testObjectProperty -InputObject $InputObject -PropertyName $PropertyName)) {
        return $InputObject.$PropertyName
    }

    return $null
}
