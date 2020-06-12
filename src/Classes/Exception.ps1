class Exception : System.Exception {

    Exception(
        [string]$Message
    ) : base($Message) {
    }

    # Exception (
    #     [string]$Message,
    #     [System.Exception]$InnerException
    # ) : base($Message, $InnerException) {
    # }
}

