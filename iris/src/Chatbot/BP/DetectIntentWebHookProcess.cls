/// 
Class Chatbot.BP.DetectIntentWebHookProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Chatbot.Msg.DetectIntentWebHookReq' response='Chatbot.Msg.DetectIntentWebHookRsp' height='2000' width='2000' >
<sequence xend='200' yend='700' >
<switch name='Handle Intents' xpos='200' ypos='350' xend='200' yend='600' >
<case condition='request.intent="get_next_appt"' name='get_next_appt' >
<sequence name='Get Next Appointments' xpos='335' ypos='500' xend='200' yend='550' >
<empty xpos='200' ypos='350' />
</sequence>
</case>
<default name='default' />
</switch>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
