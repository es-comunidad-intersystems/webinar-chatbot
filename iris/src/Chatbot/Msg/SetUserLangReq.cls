Class Chatbot.Msg.SetUserLangReq Extends Ens.Request
{

Property userId As %String;

Property lang As %String;

Storage Default
{
<Data name="SetUserLangReqDefaultData">
<Subscript>"SetUserLangReq"</Subscript>
<Value name="1">
<Value>userId</Value>
</Value>
<Value name="2">
<Value>lang</Value>
</Value>
</Data>
<DefaultData>SetUserLangReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
