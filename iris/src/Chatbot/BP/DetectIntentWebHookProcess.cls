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
</context>
<sequence xend='200' yend='600' >
<switch name='Handle Intents' xpos='200' ypos='250' xend='200' yend='500' >
<case condition='request.intent="get_next_appt"' name='get_next_appt' >
<sequence name='Get Next Appointments' xpos='335' ypos='400' xend='200' yend='650' >
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
<default name='default' />
</switch>
</sequence>
</process>
}

}
