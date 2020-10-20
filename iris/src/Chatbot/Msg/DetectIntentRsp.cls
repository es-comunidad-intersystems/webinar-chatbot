Class Chatbot.Msg.DetectIntentRsp Extends Ens.Response
{

Property text As %String(MAXLEN = "");

Property raw As %Stream.GlobalCharacter;

Storage Default
{
<Data name="DetectIntentRspDefaultData">
<Subscript>"DetectIntentRsp"</Subscript>
<Value name="1">
<Value>text</Value>
</Value>
<Value name="2">
<Value>raw</Value>
</Value>
</Data>
<DefaultData>DetectIntentRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
