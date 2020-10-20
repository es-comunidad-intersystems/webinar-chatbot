Class Chatbot.Msg.FindApptSlotReq Extends Ens.Request
{

Property apptDate As %Date;

Property schedule As %String;

Storage Default
{
<Data name="FindApptSlotReqDefaultData">
<Subscript>"FindApptSlotReq"</Subscript>
<Value name="1">
<Value>apptDate</Value>
</Value>
<Value name="2">
<Value>schedule</Value>
</Value>
</Data>
<DefaultData>FindApptSlotReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
