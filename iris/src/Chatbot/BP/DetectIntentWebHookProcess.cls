/// 
Class Chatbot.BP.DetectIntentWebHookProcess Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Chatbot.Msg.DetectIntentWebHookReq' response='Chatbot.Msg.DetectIntentWebHookRsp' height='2000' width='2000' >
<context>
<property name='nextApptRsp' type='Chatbot.Msg.GetNextApptRsp' instantiate='0' />
<property name='apptDate' type='%Date' instantiate='0' />
<property name='apptSchedule' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='' />
</parameters>
</property>
<property name='findSlotRsp' type='Chatbot.Msg.FindApptSlotRsp' instantiate='0' />
</context>
<sequence xend='200' yend='700' >
<assign name="Default response" property="response.text" value="request.fulfillmentText" action="set" xpos='200' ypos='250' >
<annotation><![CDATA[Pre-calculated DialogFlow response]]></annotation>
</assign>
<switch name='Handle Intents' xpos='200' ypos='350' xend='200' yend='600' >
<case condition='request.intent="get_next_appt"' name='get_next_appt' >
<sequence name='Get Next Appointments' xpos='335' ypos='500' xend='200' yend='650' >
<call name='Get Next Appointments' target='Data Operations' async='1' xpos='200' ypos='250' >
<annotation><![CDATA[Data Operations]]></annotation>
<request type='Chatbot.Msg.GetNextApptReq' >
<assign property="callrequest.userId" value="request.userId" action="set" />
</request>
<response type='Chatbot.Msg.GetNextApptRsp' >
<assign property="context.nextApptRsp" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait for appts rsp' calls='Get Next Appointments' timeout='10' type='all' xpos='200' ypos='350' />
<transform name='Rsp 2 WebHookRsp' class='Chatbot.DT.GetNextApptRsp2DetectIntentWebHookRsp' source='context.nextApptRsp' target='response' xpos='200' ypos='450' >
<annotation><![CDATA[Transform response to webhook response]]></annotation>
</transform>
<code name='No appointments response' xpos='200' ypos='550' >
<![CDATA[ if response.text="" {
   set response.text = "No tiene citas en los próximos días"
 }]]>
</code>
</sequence>
</case>
<case condition='request.intent="book_appt"' name='book_appt' >
<sequence name='Book Appointment' xpos='605' ypos='500' xend='200' yend='650' >
<code name='Parse params' xpos='200' ypos='250' >
<![CDATA[ set apptDateValue = {}.%FromJSON(request.raw).queryResult.parameters."appt_date"
 set context.apptDate = $zdateh($piece(apptDateValue, "T", 1), 3)
 
 set context.apptSchedule = {}.%FromJSON(request.raw).queryResult.parameters."appt_schedule"]]>
</code>
<call name='Find Appt Slots' target='Data Operations' async='1' xpos='200' ypos='350' >
<request type='Chatbot.Msg.FindApptSlotReq' >
<assign property="callrequest.apptDate" value="context.apptDate" action="set" />
<assign property="callrequest.schedule" value="context.apptSchedule" action="set" />
</request>
<response type='Chatbot.Msg.FindApptSlotRsp' >
<assign property="context.findSlotRsp" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait for find slots rsp' calls='Find Appt Slots' timeout='30' type='all' xpos='200' ypos='450' />
<code name='Set response' xpos='200' ypos='550' >
<![CDATA[ set appt = context.findSlotRsp.appt
 
 // slot available
 if $isobject(appt) 
 {
   set response.text = "Tienes un hueco disponible para "_appt.Schedule_" el día "_$zdate(appt.ApptDate,4)_" con "_appt.Doctor_" a las "_$ztime(appt.StartTime, 2)_". ¿Quieres confirmar la cita?"
   set outputContexts = [
            {
                "name":(request.session_"/contexts/book_appt-followup"),
                "lifespanCount":5,
                "parameters": {
                    "appt_date":"2020-10-26T12:00:00+02:00",
                    "hola":"adios"
                }
            }
        ]
    set response.outputContexts = outputContexts.%ToJSON()
 }
 
 // slot not-available
 else 
 {
   set response.text = "Lo siento, no tenemos huecos disponibles."
 }]]>
</code>
</sequence>
</case>
<default name='default' />
</switch>
</sequence>
</process>
}

}
