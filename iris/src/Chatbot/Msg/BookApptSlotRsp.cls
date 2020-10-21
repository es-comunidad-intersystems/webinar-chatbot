Class Chatbot.Msg.BookApptSlotRsp Extends Ens.Response
{

Property appt As Chatbot.Data.Appointment;

Property done As %Boolean;

Storage Default
{
<Data name="BookApptSlotRspDefaultData">
<Subscript>"BookApptSlotRsp"</Subscript>
<Value name="1">
<Value>appt</Value>
</Value>
<Value name="2">
<Value>done</Value>
</Value>
</Data>
<DefaultData>BookApptSlotRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
