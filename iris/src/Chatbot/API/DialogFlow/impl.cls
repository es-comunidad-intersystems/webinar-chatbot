/// Receive a requests from Dialogflow in the form of the response to a user query matched by intents with webhook enabled<br/>
/// Business logic class defined by OpenAPI in Chatbot.API.DialogFlow.spec<br/>
/// Created Oct 8, 2020 08:48:21
Class Chatbot.API.DialogFlow.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 0;

/// Process a WebHookRequest from Dialog Flow<br/>
/// The method arguments hold values for:<br/>
///     body, WebHookRequest<br/>
ClassMethod processWebHook(body As %DynamicObject) As %DynamicObject
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object

    quit { "msg": "well done" }
}

}
