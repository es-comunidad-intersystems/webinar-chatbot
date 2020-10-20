Class Chatbot.Msg.RegisterUserRsp Extends Ens.Response
{

Property user As Chatbot.Data.User;

Storage Default
{
<Data name="RegisterUserRspDefaultData">
<Subscript>"RegisterUserRsp"</Subscript>
<Value name="1">
<Value>user</Value>
</Value>
</Data>
<DefaultData>RegisterUserRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
