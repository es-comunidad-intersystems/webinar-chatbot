Class Chatbot.Msg.RegisterUserRsp Extends Ens.Response
{

Property result As %String;

Storage Default
{
<Data name="RegisterUserRspDefaultData">
<Subscript>"RegisterUserRsp"</Subscript>
<Value name="1">
<Value>result</Value>
</Value>
</Data>
<DefaultData>RegisterUserRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
