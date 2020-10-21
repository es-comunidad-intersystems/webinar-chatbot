Class Chatbot.Msg.TranslateReq Extends Ens.Request
{

Property text As %String(MAXLEN = "");

Property sourceLang As %String;

Property targetLang As %String;

Storage Default
{
<Data name="TranslateReqDefaultData">
<Subscript>"TranslateReq"</Subscript>
<Value name="1">
<Value>text</Value>
</Value>
<Value name="2">
<Value>sourceLang</Value>
</Value>
<Value name="3">
<Value>targetLang</Value>
</Value>
</Data>
<DefaultData>TranslateReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
