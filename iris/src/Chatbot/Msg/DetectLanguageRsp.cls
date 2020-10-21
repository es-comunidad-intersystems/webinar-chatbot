Class Chatbot.Msg.DetectLanguageRsp Extends Ens.Response
{

Property language As %String(MAXLEN = "");

Property confidence As %String;

Property isReliable As %Boolean;

Property raw As %Stream.GlobalCharacter;

Storage Default
{
<Data name="DetectLanguageRspDefaultData">
<Subscript>"DetectLanguageRsp"</Subscript>
<Value name="1">
<Value>language</Value>
</Value>
<Value name="2">
<Value>confidence</Value>
</Value>
<Value name="3">
<Value>isReliable</Value>
</Value>
<Value name="4">
<Value>raw</Value>
</Value>
</Data>
<DefaultData>DetectLanguageRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
