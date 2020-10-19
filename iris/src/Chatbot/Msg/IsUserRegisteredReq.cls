Class Chatbot.Msg.IsUserRegisteredReq Extends Ens.Request
{

Property userId As %String;

Storage Default
{
<Data name="IsUserRegisteredReqDefaultData">
<Subscript>"IsUserRegisteredReq"</Subscript>
<Value name="1">
<Value>userId</Value>
</Value>
</Data>
<DefaultData>IsUserRegisteredReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
