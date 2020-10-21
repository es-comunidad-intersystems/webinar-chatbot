Class Chatbot.Msg.TranslateRsp Extends Ens.Response
{

Property translatedText As %String(MAXLEN = "");

Property raw As %Stream.GlobalCharacter;

Storage Default
{
<Data name="TranslateRspDefaultData">
<Subscript>"TranslateRsp"</Subscript>
<Value name="1">
<Value>translatedText</Value>
</Value>
<Value name="2">
<Value>raw</Value>
</Value>
</Data>
<DefaultData>TranslateRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
