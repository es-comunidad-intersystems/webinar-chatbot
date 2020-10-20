Class Chatbot.Msg.TelegramWebHookReq Extends Ens.Request
{

Property userId As %String;

Property chatId As %String;

Property text As %String(MAXLEN = "");

Property command As %String;

Property params As %String;

Property raw As %Stream.GlobalCharacter;

Storage Default
{
<Data name="TelegramWebHookReqDefaultData">
<Subscript>"TelegramWebHookReq"</Subscript>
<Value name="1">
<Value>userId</Value>
</Value>
<Value name="2">
<Value>chatId</Value>
</Value>
<Value name="3">
<Value>text</Value>
</Value>
<Value name="4">
<Value>command</Value>
</Value>
<Value name="5">
<Value>params</Value>
</Value>
<Value name="6">
<Value>raw</Value>
</Value>
</Data>
<DefaultData>TelegramWebHookReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
