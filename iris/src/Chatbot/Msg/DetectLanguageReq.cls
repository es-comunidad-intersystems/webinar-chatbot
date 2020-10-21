Class Chatbot.Msg.DetectLanguageReq Extends Ens.Request
{

Property text As %String(MAXLEN = "");

Storage Default
{
<Data name="DetectLanguageReqDefaultData">
<Subscript>"DetectLanguageReq"</Subscript>
<Value name="1">
<Value>text</Value>
</Value>
</Data>
<DefaultData>DetectLanguageReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
