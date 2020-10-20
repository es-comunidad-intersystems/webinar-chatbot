Class Chatbot.Msg.DetectIntentWebHookReq Extends Ens.Request
{

Property intent As %String(MAXLEN = "");

Property allRequiredParamsPresent As %Boolean;

Property userId As %String(MAXLEN = "");

Property fulfillmentText As %String(MAXLEN = "");

Property session As %String(MAXLEN = "");

Property raw As %Stream.GlobalCharacter;

Storage Default
{
<Data name="DetectIntentWebHookReqDefaultData">
<Subscript>"DetectIntentWebHookReq"</Subscript>
<Value name="1">
<Value>intent</Value>
</Value>
<Value name="2">
<Value>allRequiredParamsPresent</Value>
</Value>
<Value name="3">
<Value>userId</Value>
</Value>
<Value name="4">
<Value>fulfillmentText</Value>
</Value>
<Value name="5">
<Value>session</Value>
</Value>
<Value name="6">
<Value>raw</Value>
</Value>
</Data>
<DefaultData>DetectIntentWebHookReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
