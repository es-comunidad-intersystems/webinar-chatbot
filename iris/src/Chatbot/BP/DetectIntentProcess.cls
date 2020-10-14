/// 
Class Chatbot.BP.DetectIntentProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Chatbot.Msg.DetectIntentReq' response='Chatbot.Msg.DetectIntentRsp' height='2000' width='2000' >
<context>
<property name='pexTokenRsp' type='EnsLib.PEX.Message' instantiate='0' />
</context>
<sequence xend='200' yend='750' >
<call name='Google Auth Token' target='Google Auth Token Oper' async='1' xpos='200' ypos='250' >
<annotation><![CDATA[Get Token]]></annotation>
<request type='Chatbot.Msg.DetectIntentReq' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='EnsLib.PEX.Message' >
<assign property="context.pexTokenRsp" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait for Token' calls='Google Auth Token' timeout='10' type='all' xpos='200' ypos='350' />
<code name='Prepare Session' xpos='200' ypos='450' >
<annotation><![CDATA[Set session value for Dialog Flow]]></annotation>
<![CDATA[ set request.session = "projects/iris-chatbot/agent/sessions/"_request.session_":detectIntent"]]>
</code>
<call name='DetectIntent' target='DialogFlow DetectIntent' async='1' xpos='200' ypos='550' >
<request type='Chatbot.Msg.DetectIntentReq' >
<assign property="callrequest" value="request" action="set" />
<assign property="callrequest.tokenValue" value="context.pexTokenRsp.%jsonObject.tokenValue" action="set" />
</request>
<response type='Chatbot.Msg.DetectIntentRsp' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait for DetectIntent' calls='DetectIntent' timeout='10' type='all' xpos='200' ypos='650' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
