Class Chatbot.Msg.RegisterUserReq Extends Ens.Request
{

Property userId As %String;

Storage Default
{
<Data name="RegisterUserReqDefaultData">
<Subscript>"RegisterUserReq"</Subscript>
<Value name="1">
<Value>userId</Value>
</Value>
</Data>
<DefaultData>RegisterUserReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
