Class Chatbot.Msg.DetectIntentWebHookRsp Extends Ens.Response
{

Property text As %String(MAXLEN = "");

Storage Default
{
<Data name="DetectIntentWebHookRspDefaultData">
<Subscript>"DetectIntentWebHookRsp"</Subscript>
<Value name="1">
<Value>text</Value>
</Value>
</Data>
<DefaultData>DetectIntentWebHookRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
