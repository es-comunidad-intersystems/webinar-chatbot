Class Chatbot.Msg.TelegramMsgReq Extends Ens.Request
{

Property text As %String(MAXLEN = "");

Property chatId As %String(MAXLEN = "");

Storage Default
{
<Data name="TelegramMsgReqDefaultData">
<Subscript>"TelegramMsgReq"</Subscript>
<Value name="1">
<Value>text</Value>
</Value>
<Value name="2">
<Value>chatId</Value>
</Value>
</Data>
<DefaultData>TelegramMsgReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
