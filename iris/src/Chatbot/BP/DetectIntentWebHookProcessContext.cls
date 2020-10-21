Class Chatbot.BP.DetectIntentWebHookProcessContext Extends Ens.BP.Context
{

/// get_next_appt: get next appointments data operation response
Property nextApptRsp As Chatbot.Msg.GetNextApptRsp;

/// book_appt: appointment date
Property apptDate As %Date;

/// book_appt: appointment schedule
Property apptSchedule As %String(MAXLEN = "");

/// book_appt: find slot data operation response
Property findSlotRsp As Chatbot.Msg.FindApptSlotRsp;

/// book_appt_yes: slot id
Property apptId As %String;

/// book_appt_yes: book slot data operation response
Property bookSlotRsp As Chatbot.Msg.BookApptSlotRsp;

/// book_appt: parse incoming parameters
Method BookApptParseParams(request As Chatbot.Msg.DetectIntentWebHookReq) As %Status
{
    set ret = $$$OK
    try {
        set jsonObj = {}.%FromJSON(request.raw)

        // appointment date
        set apptDateValue = jsonObj.queryResult.parameters."appt_date"
        set ..apptDate = $zdateh($piece(apptDateValue, "T", 1), 3)
 
        // appointment schedule
        set ..apptSchedule = jsonObj.queryResult.parameters."appt_schedule"

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

/// book_appt: set response depending on available slots
Method BookApptSetResponse(request As Chatbot.Msg.DetectIntentWebHookReq, response As Chatbot.Msg.DetectIntentWebHookRsp) As %Status
{
    set ret = $$$OK
    try {
        set appt = ..findSlotRsp.appt
    
        // slot available
        if $isobject(appt) {
            set response.text = "Tienes un hueco disponible para "_appt.Schedule_" el día "_$zdate(appt.ApptDate,4)_" con "_appt.Doctor_" a las "_$ztime(appt.StartTime, 2)_". ¿Quieres confirmar la cita?"
            set outputContexts = [{
                "name":(request.session_"/contexts/book_appt-followup"),
                "lifespanCount":5,
                "parameters": {
                    "appt_date":($zdate(appt.ApptDate,3)_"T"_$ztime(appt.StartTime,1)_"+02:00"),
                    "appt_id":(appt.%Id())
                }
            }]
            set response.outputContexts = outputContexts.%ToJSON()
        }
        // slot not-available
        else {
            set response.text = "Lo siento, no tenemos huecos disponibles."
        }

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

/// book_appt_yes: parse incoming parameters
Method BookApptYesParseParams(request As Chatbot.Msg.DetectIntentWebHookReq) As %Status
{
    set ret = $$$OK
    try {
        set jsonObj = {}.%FromJSON(request.raw)

        // find "bookappt-followup" contexts
        set iter = jsonObj.queryResult.outputContexts.%GetIterator()
        while iter.%GetNext(.key, .value) {
            if value.name=(request.session_"/contexts/book_appt-followup") {
            
                // appointment id
                set ..apptId = value.parameters."appt_id"
            }
        }

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

/// book_appt_yes: parse incoming parameters
Method BookApptYesSetResponse(request As Chatbot.Msg.DetectIntentWebHookReq, response As Chatbot.Msg.DetectIntentWebHookRsp) As %Status
{
    set ret = $$$OK
    try {
        set appt = ..bookSlotRsp.appt
    
        // slot available
        if ..bookSlotRsp.done {
            set response.text = "Cita de "_appt.Schedule_" confirmada! Día "_$zdate(appt.ApptDate,4)_" de "_$ztime(appt.StartTime, 2)_" a "_$ztime(appt.EndTime, 2)_" con "_appt.Doctor
        }
        // slot not-available
        else {
            set response.text = "Lo siento, no ha sido posible confirmar tu cita."
        }

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

Storage Default
{
<Data name="DetectIntentWebHookProcessContextDefaultData">
<Subscript>"DetectIntentWebHookProcessContext"</Subscript>
<Value name="1">
<Value>nextApptRsp</Value>
</Value>
<Value name="2">
<Value>apptDate</Value>
</Value>
<Value name="3">
<Value>apptSchedule</Value>
</Value>
<Value name="4">
<Value>findSlotRsp</Value>
</Value>
<Value name="5">
<Value>apptId</Value>
</Value>
<Value name="6">
<Value>bookSlotRsp</Value>
</Value>
</Data>
<DefaultData>DetectIntentWebHookProcessContextDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
