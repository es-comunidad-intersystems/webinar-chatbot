Class Chatbot.Data.User Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor)
{

/// User identification
Property userId As %String;

/// User is registered
Property registered As %Boolean;

/// Patient number
Property patientNo As %String;

/// User language
Property lang As %String [ InitialExpression = "es" ];

Index UserIdKey On userId [ IdKey, Unique ];

Storage Default
{
<Data name="UserDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>registered</Value>
</Value>
<Value name="3">
<Value>patientNo</Value>
</Value>
<Value name="4">
<Value>lang</Value>
</Value>
</Data>
<DataLocation>^Chatbot.Data.UserD</DataLocation>
<DefaultData>UserDefaultData</DefaultData>
<IdLocation>^Chatbot.Data.UserD</IdLocation>
<IndexLocation>^Chatbot.Data.UserI</IndexLocation>
<StreamLocation>^Chatbot.Data.UserS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
