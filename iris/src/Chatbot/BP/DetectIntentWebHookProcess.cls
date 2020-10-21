/// 
Class Chatbot.BP.DetectIntentWebHookProcess Extends Ens.BusinessProcessBPL [ DependsOn = Chatbot.BP.DetectIntentWebHookProcessContext ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Chatbot.Msg.DetectIntentWebHookReq' response='Chatbot.Msg.DetectIntentWebHookRsp' contextsuperclass='Chatbot.BP.DetectIntentWebHookProcessContext' height='2000' width='2000' >
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
<code name='Set response' xpos='200' ypos='550' >
<![CDATA[ if response.text="" {
   set response.text = "No tiene citas en los próximos días"
 } else {
   set response.text = "Tus próximas citas son:"_$char(10)_response.text
 }]]>
</code>
</sequence>
</case>
<case condition='request.intent="book_appt"' name='book_appt' >
<sequence name='Book Appointment' xpos='605' ypos='500' xend='200' yend='650' >
<code name='Parse params' xpos='200' ypos='250' >
<annotation><![CDATA[Parse incoming parameters (date, schedule)]]></annotation>
<![CDATA[ set sc = context.BookApptParseParams(request)
 $$$ThrowOnError(sc)]]>
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
<annotation><![CDATA[Set response depending on available slots]]></annotation>
<![CDATA[ set sc = context.BookApptSetResponse(request, response)
 $$$ThrowOnError(sc)]]>
</code>
</sequence>
</case>
<case condition='request.intent="book_appt - yes"' name='book_appt - yes' >
<sequence name='Book Appt Yes' xpos='875' ypos='500' xend='200' yend='650' >
<code name='Parse Params' xpos='200' ypos='250' >
<annotation><![CDATA[Parse incoming parameters]]></annotation>
<![CDATA[ set sc = context.BookApptYesParseParams(request)
 $$$ThrowOnError(sc)
 ]]>
</code>
<call name='Book Appointment' target='Data Operations' async='1' xpos='200' ypos='350' >
<request type='Chatbot.Msg.BookApptSlotReq' >
<assign property="callrequest.apptId" value="context.apptId" action="set" />
<assign property="callrequest.userId" value="request.userId" action="set" />
</request>
<response type='Chatbot.Msg.BookApptSlotRsp' >
<assign property="context.bookSlotRsp" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait for booking rsp' calls='Book Appointment' timeout='30' type='all' xpos='200' ypos='450' />
<code name='Set response' xpos='200' ypos='550' >
<annotation><![CDATA[Set response depending on book appointment confirmation]]></annotation>
<![CDATA[ set sc = context.BookApptYesSetResponse(request, response)
 $$$ThrowOnError(sc)]]>
</code>
</sequence>
</case>
<default name='default' />
</switch>
</sequence>
</process>
}

}
