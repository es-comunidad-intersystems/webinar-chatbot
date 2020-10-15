Class Chatbot.Msg.TelegramMsgRsp Extends Ens.Response
{

Property raw As %Stream.GlobalCharacter;

Storage Default
{
<Data name="TelegramMsgRspDefaultData">
<Subscript>"TelegramMsgRsp"</Subscript>
<Value name="1">
<Value>raw</Value>
</Value>
</Data>
<DefaultData>TelegramMsgRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
