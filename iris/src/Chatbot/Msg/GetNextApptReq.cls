Class Chatbot.Msg.GetNextApptReq Extends Ens.Request
{

Property userId As %String;

Storage Default
{
<Data name="GetNextApptReqDefaultData">
<Subscript>"GetNextApptReq"</Subscript>
<Value name="1">
<Value>userId</Value>
</Value>
</Data>
<DefaultData>GetNextApptReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
