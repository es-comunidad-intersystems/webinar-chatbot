/// 
Class Chatbot.BP.TelegramWebHookProcess Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Chatbot.Msg.TelegramWebHookReq' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='telegramMsg' type='Chatbot.Msg.TelegramMsgReq' instantiate='0' />
<property name='userRegistered' type='%Boolean' instantiate='0' />
<property name='payload' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='' />
</parameters>
</property>
</context>
<sequence xend='200' yend='1150' >
<if name='Telegram Command?' condition='request.command&apos;=""' xpos='200' ypos='250' xend='200' yend='950' >
<true>
<switch name='Handle Command' xpos='200' ypos='400' xend='200' yend='650' >
<case condition='request.command="/registro"' name='/registro' >
<sequence name='/registro' xpos='200' ypos='550' xend='200' yend='450' >
<call name='Register User' target='Data Operations' async='1' xpos='200' ypos='250' >
<annotation><![CDATA[Data Operations]]></annotation>
<request type='Chatbot.Msg.RegisterUserReq' >
<assign property="callrequest.userId" value="request.userId" action="set" />
</request>
<response type='Chatbot.Msg.RegisterUserRsp' >
<assign property="context.telegramMsg.text" value="&quot;Usuario &quot;_callresponse.user.userId_&quot; registrado como paciente &quot;_callresponse.user.patientNo" action="set" />
</response>
</call>
<sync name='Wait for response' calls='Register User' type='all' xpos='200' ypos='350' />
</sequence>
</case>
<case condition='(request.command="/start")||(request.command="/ayuda")' name='/start /ayuda' >
<sequence name='/start /ayuda' xpos='470' ypos='550' xend='200' yend='350' >
<assign name="Set command response" property="context.telegramMsg.text" value="&quot;Hola! Soy un chatbot de demo que está aprendiendo a chatear con pacientes :) &quot;_$c(10)_$c(10)_&quot;Puedes utilizar los comandos:&quot;_$c(10)_&quot;/registro - Registrarte como paciente&quot;_$c(10)_&quot;/ayuda - Mostrar esta ayuda&quot;_$c(10)_$c(10)_&quot;Una vez registrado, puedes escribirme frases como:&quot;_$c(10)_&quot;- hola amigo!&quot;_$c(10)_&quot;- qué citas tengo?&quot;_$c(10)_&quot;- quiero programar una cita para mañana&quot;" action="set" xpos='200' ypos='250' />
</sequence>
</case>
<default>
<assign name="Default Telegram Response" property="context.telegramMsg.text" value="&quot;Comando no reconocido&quot;" action="set" xpos='740' ypos='550' />
</default>
</switch>
</true>
<false>
<call name='IsUserRegistered' target='Data Operations' async='1' xpos='1010' ypos='400' >
<annotation><![CDATA[Data Operations]]></annotation>
<request type='Chatbot.Msg.IsUserRegisteredReq' >
<assign property="callrequest.userId" value="request.userId" action="set" />
</request>
<response type='Chatbot.Msg.IsUserRegisteredRsp' >
<assign property="context.userRegistered" value="callresponse.registered" action="set" />
</response>
</call>
<sync name='Wait for rsp' calls='IsUserRegistered' timeout='10' type='all' xpos='1010' ypos='500' />
<if name='User Registered?' condition='context.userRegistered=1' xpos='1010' ypos='600' xend='1010' yend='850' >
<true>
<sequence name='detectIntent' xpos='1280' ypos='750' xend='200' yend='550' >
<annotation><![CDATA[Dialog Flow]]></annotation>
<assign name="Set default response" property="context.telegramMsg.text" value="&quot;Default empty response&quot;" action="set" xpos='200' ypos='250' />
<call name='Detect Intent Process' target='DetectIntent Process' async='1' xpos='200' ypos='350' >
<request type='Chatbot.Msg.DetectIntentReq' >
<assign property="callrequest.session" value="request.userId" action="set" />
<assign property="callrequest.text" value="request.text" action="set" />
<assign property="callrequest.lang" value="&quot;es&quot;" action="set" />
<assign property="callrequest.payload" value="{&quot;userId&quot;: (request.userId) }.%ToJSON()" action="set" />
</request>
<response type='Chatbot.Msg.DetectIntentRsp' >
<assign property="context.telegramMsg.text" value="callresponse.text" action="set" />
</response>
</call>
<sync name='Wait detectIntent rsp' calls='Detect Intent Process' timeout='60' type='all' xpos='200' ypos='450' />
</sequence>
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

}
