Class Chatbot.Msg.GetUserInfoReq Extends Ens.Request
{

Property userId As %String;

Storage Default
{
<Data name="GetUserInfoReqDefaultData">
<Subscript>"GetUserInfoReq"</Subscript>
<Value name="1">
<Value>userId</Value>
</Value>
</Data>
<DefaultData>GetUserInfoReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
