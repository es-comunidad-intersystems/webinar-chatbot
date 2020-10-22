Class Chatbot.Util Extends %RegisteredObject
{

/// write ##class(Chatbot.Util).ResetDemo()
ClassMethod ResetDemo() As %Status
{
    set ret = $$$OK
    try {
        $$$ThrowOnError(##class(Chatbot.Data.Appointment).CreateSlots())
        $$$ThrowOnError(##class(Chatbot.Data.User).%DeleteExtent())

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

}
