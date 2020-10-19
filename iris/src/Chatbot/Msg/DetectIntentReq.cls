Class Chatbot.Msg.DetectIntentReq Extends Ens.Request
{

Property text As %String(MAXLEN = "");

Property lang As %String;

Property session As %String(MAXLEN = "");

Property tokenValue As %String(MAXLEN = "");

Property payload As %String(MAXLEN = "");

Storage Default
{
<Data name="DetectIntentReqDefaultData">
<Subscript>"DetectIntentReq"</Subscript>
<Value name="1">
<Value>text</Value>
</Value>
<Value name="2">
<Value>lang</Value>
</Value>
<Value name="3">
<Value>session</Value>
</Value>
<Value name="4">
<Value>tokenValue</Value>
</Value>
<Value name="5">
<Value>payload</Value>
</Value>
</Data>
<DefaultData>DetectIntentReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
