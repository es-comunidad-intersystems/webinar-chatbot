Class Chatbot.Msg.IsUserRegisteredRsp Extends Ens.Response
{

Property userId As %String;

Property registered As %Boolean;

Storage Default
{
<Data name="IsUserRegisteredRspDefaultData">
<Subscript>"IsUserRegisteredRsp"</Subscript>
<Value name="1">
<Value>userId</Value>
</Value>
<Value name="2">
<Value>registered</Value>
</Value>
</Data>
<DefaultData>IsUserRegisteredRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
