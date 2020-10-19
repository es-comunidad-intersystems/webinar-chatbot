/// 
Class Chatbot.BP.TelegramWebHookProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Chatbot.Msg.TelegramWebHookReq' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='telegramMsg' type='Chatbot.Msg.TelegramMsgReq' instantiate='0' />
<property name='userRegistered' type='%Boolean' instantiate='0' />
</context>
<sequence xend='200' yend='1150' >
<if name='Telegram Command?' condition='request.command&apos;=""' xpos='200' ypos='250' xend='200' yend='950' >
<true>
<switch name='Handle Command' xpos='200' ypos='400' xend='200' yend='650' >
<case condition='request.command="/registro"' name='/registro' >
<sequence name='/registro' xpos='200' ypos='550' xend='200' yend='550' >
<call name='Register User' target='Data Operations' async='1' xpos='200' ypos='250' >
<annotation><![CDATA[Data Operations]]></annotation>
<request type='Chatbot.Msg.RegisterUserReq' >
<assign property="callrequest.userId" value="request.userId" action="set" />
</request>
<response type='Ens.Response' />
</call>
<sync name='Wait for response' calls='Register User' type='all' xpos='200' ypos='350' />
<assign name="Set Telegram response" property="context.telegramMsg.text" value="&quot;Usuario registrado&quot;" action="set" xpos='200' ypos='450' />
</sequence>
</case>
<default>
<assign name="Default Telegram Response" property="context.telegramMsg.text" value="&quot;Comando no reconocido&quot;" action="set" xpos='470' ypos='550' />
</default>
</switch>
</true>
<false>
<call name='IsUserRegistered' target='Data Operations' async='1' xpos='740' ypos='400' >
<annotation><![CDATA[Data Operations]]></annotation>
<request type='Chatbot.Msg.IsUserRegisteredReq' >
<assign property="callrequest.userId" value="request.userId" action="set" />
</request>
<response type='Chatbot.Msg.IsUserRegisteredRsp' >
<assign property="context.userRegistered" value="callresponse.registered" action="set" />
</response>
</call>
<sync name='Wait for rsp' calls='IsUserRegistered' timeout='10' type='all' xpos='740' ypos='500' />
<if name='User Registered?' condition='context.userRegistered=1' xpos='740' ypos='600' xend='740' yend='850' >
<true>
<assign name="detectIntent" property="context.telegramMsg.text" value="&quot;detectIntent&quot;" action="set" xpos='740' ypos='750' />
</true>
<false>
<assign name="Not Registered Response" property="context.telegramMsg.text" value="&quot;No estás registrado. Debes registrarte primero.&quot;" action="set" xpos='1010' ypos='750' />
</false>
</if>
</false>
</if>
<call name='Telegram Send' target='Telegram SendMessage' async='1' xpos='200' ypos='1050' >
<annotation><![CDATA[Send telegram response to user]]></annotation>
<request type='Chatbot.Msg.TelegramMsgReq' >
<assign property="callrequest" value="context.telegramMsg" action="set" />
<assign property="callrequest.chatId" value="request.chatId" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
