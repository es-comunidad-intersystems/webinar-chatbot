Class Chatbot.Msg.FindApptSlotRsp Extends Ens.Response
{

Property appt As Chatbot.Data.Appointment;

Storage Default
{
<Data name="FindApptSlotRspDefaultData">
<Subscript>"FindApptSlotRsp"</Subscript>
<Value name="1">
<Value>appt</Value>
</Value>
</Data>
<DefaultData>FindApptSlotRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
