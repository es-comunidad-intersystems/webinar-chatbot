Class Chatbot.Msg.GetNextApptRsp Extends Ens.Response
{

Property apptList As list Of %String;

Storage Default
{
<Data name="GetNextApptRspDefaultData">
<Subscript>"GetNextApptRsp"</Subscript>
<Value name="1">
<Value>apptList</Value>
</Value>
</Data>
<DefaultData>GetNextApptRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
