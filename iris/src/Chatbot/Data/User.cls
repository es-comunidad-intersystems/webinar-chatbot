Class Chatbot.Data.User Extends (%Persistent, %JSON.Adaptor)
{

Property userId As %String;

Property registered As %Boolean;

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
</Data>
<DataLocation>^Chatbot.Data.UserD</DataLocation>
<DefaultData>UserDefaultData</DefaultData>
<IdLocation>^Chatbot.Data.UserD</IdLocation>
<IndexLocation>^Chatbot.Data.UserI</IndexLocation>
<StreamLocation>^Chatbot.Data.UserS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
