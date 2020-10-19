Class Chatbot.Msg.GetUserInfoRsp Extends Ens.Response
{

Property user As Chatbot.Data.User;

Storage Default
{
<Data name="GetUserInfoRspDefaultData">
<Subscript>"GetUserInfoRsp"</Subscript>
<Value name="1">
<Value>user</Value>
</Value>
</Data>
<DefaultData>GetUserInfoRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
