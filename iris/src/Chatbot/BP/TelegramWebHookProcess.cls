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
<process language='objectscript' request='Chatbot.Msg.TelegramWebHookReq' response='Ens.Response' height='2000' width='2150' >
<context>
<property name='telegramMsg' type='Chatbot.Msg.TelegramMsgReq' instantiate='0' />
<property name='userInfo' type='Chatbot.Msg.GetUserInfoRsp' instantiate='0' />
<property name='payload' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='' />
</parameters>
</property>
<property name='detectedLanguage' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='text' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='' />
</parameters>
</property>
<property name='setLangRsp' type='Chatbot.Msg.SetUserLangRsp' instantiate='0' />
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
<case condition='request.command="/idioma"' name='/idioma' >
<sequence name='/idioma' xpos='740' ypos='550' xend='200' yend='800' >
<call name='Set User Lang' target='Data Operations' async='1' xpos='200' ypos='250' >
<request type='Chatbot.Msg.SetUserLangReq' >
<assign property="callrequest.lang" value="request.params" action="set" />
<assign property="callrequest.userId" value="request.userId" action="set" />
</request>
<response type='Chatbot.Msg.SetUserLangRsp' >
<assign property="context.setLangRsp" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait for set lang rsp' calls='Set User Lang' timeout='60' type='all' xpos='200' ypos='350' />
<if name='Lang changed?' condition='context.setLangRsp.done' xpos='200' ypos='450' xend='200' yend='700' >
<true>
<assign name="Set response changed" property="context.telegramMsg.text" value="&quot;Idioma &quot;_request.params_&quot; guardado&quot;" action="set" xpos='470' ypos='600' />
</true>
<false>
<assign name="Set response not changed" property="context.telegramMsg.text" value="&quot;No se ha podido guardar tu idioma. ¿Estás registrado correctamente?&quot;" action="set" xpos='200' ypos='600' />
</false>
</if>
</sequence>
</case>
<default>
<assign name="Default Telegram Response" property="context.telegramMsg.text" value="&quot;Comando no reconocido&quot;" action="set" xpos='1010' ypos='550' />
</default>
</switch>
</true>
<false>
<call name='GetUserInfo' target='Data Operations' async='1' xpos='1280' ypos='400' >
<annotation><![CDATA[Data Operations]]></annotation>
<request type='Chatbot.Msg.GetUserInfoReq' >
<assign property="callrequest.userId" value="request.userId" action="set" />
</request>
<response type='Chatbot.Msg.GetUserInfoRsp' >
<assign property="context.userInfo" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait for rsp' calls='GetUserInfo' timeout='10' type='all' xpos='1280' ypos='500' />
<if name='User Registered?' condition='($isobject(context.userInfo.user) &amp;&amp; (context.userInfo.user.registered))' xpos='1280' ypos='600' xend='1280' yend='850' >
<true>
<sequence name='detectIntent' xpos='1550' ypos='750' xend='200' yend='1550' >
<annotation><![CDATA[Dialog Flow]]></annotation>
<assign name="Fetch input text" property="context.text" value="request.text" action="set" xpos='200' ypos='250' />
<assign name="Set default response" property="context.telegramMsg.text" value="&quot;Default empty response&quot;" action="set" xpos='200' ypos='350' />
<if name='User lang = cat?' condition='context.userInfo.user.lang="ca"' xpos='200' ypos='450' xend='200' yend='800' >
<true>
<call name='Translate input' target='Google Translate' async='1' xpos='335' ypos='600' >
<request type='Chatbot.Msg.TranslateReq' >
<assign property="callrequest.text" value="request.text" action="set" />
<assign property="callrequest.targetLang" value="&quot;es&quot;" action="set" />
<assign property="callrequest.sourceLang" value="&quot;ca&quot;" action="set" />
</request>
<response type='Chatbot.Msg.TranslateRsp' >
<assign property="context.text" value="callresponse.translatedText" action="set" />
</response>
</call>
<sync name='Wait for input translation' calls='Translate input' timeout='60' type='all' xpos='335' ypos='700' />
</true>
</if>
<call name='Detect Intent Process' target='DetectIntent Process' async='1' xpos='200' ypos='900' >
<request type='Chatbot.Msg.DetectIntentReq' >
<assign property="callrequest.session" value="request.userId" action="set" />
<assign property="callrequest.text" value="context.text" action="set" />
<assign property="callrequest.lang" value="&quot;es&quot;" action="set" />
<assign property="callrequest.payload" value="{&quot;userId&quot;: (request.userId) }.%ToJSON()" action="set" />
</request>
<response type='Chatbot.Msg.DetectIntentRsp' >
<assign property="context.telegramMsg.text" value="callresponse.text" action="set" />
</response>
</call>
<sync name='Wait detectIntent rsp' calls='Detect Intent Process' timeout='60' type='all' xpos='200' ypos='1000' />
<if name='User lang = cat?' condition='context.userInfo.user.lang="ca"' xpos='200' ypos='1100' xend='200' yend='1450' >
<true>
<call name='Translate output' target='Google Translate' async='1' xpos='335' ypos='1250' >
<request type='Chatbot.Msg.TranslateReq' >
<assign property="callrequest.text" value="context.telegramMsg.text" action="set" />
<assign property="callrequest.sourceLang" value="&quot;es&quot;" action="set" />
<assign property="callrequest.targetLang" value="&quot;ca&quot;" action="set" />
</request>
<response type='Chatbot.Msg.TranslateRsp' >
<assign property="context.telegramMsg.text" value="callresponse.translatedText" action="set" />
</response>
</call>
<sync name='Wait for output translation' calls='Translate output' timeout='60' type='all' xpos='335' ypos='1350' />
</true>
</if>
</sequence>
</true>
<false>
<assign name="Not Registered Response" property="context.telegramMsg.text" value="&quot;No estás registrado. Debes registrarte primero.&quot;" action="set" xpos='1280' ypos='750' />
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
