/// Receive a requests from Dialogflow in the form of the response to a user query matched by intents with webhook enabled<br/>
/// Business logic class defined by OpenAPI in Chatbot.API.DialogFlow.spec<br/>
/// Created Oct 8, 2020 08:48:21
Class Chatbot.API.DialogFlow.impl Extends (%REST.Impl, Ens.BusinessService) [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Process a WebHookRequest from Dialog Flow<br/>
/// The method arguments hold values for:<br/>
///     body, WebHookRequest<br/>
ClassMethod processWebHook(body As %DynamicObject) As %DynamicObject
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
    
    // instantiate Business Service (interoperability framework)
    set sc = ##class(Ens.Director).CreateBusinessService("Chatbot.API.DialogFlow.impl",.service)
    $$$ThrowOnError(sc)

    // build request message
    set formatter = ##class(%JSON.Formatter).%New()
    do formatter.FormatToStream(body, .formatted)
    
    set req = ##class(Chatbot.Msg.DetectIntentWebHookReq).%New()
    set req.raw = formatted
    
    // extract fields
    set jsonObj = {}.%FromJSON(req.raw)
    set req.intent = jsonObj.queryResult.intent.displayName
    set req.allRequiredParamsPresent = jsonObj.queryResult.allRequiredParamsPresent
    set req.userId = jsonObj.originalDetectIntentRequest.payload.userId

    // send message
    set sc = service.SendRequestSync("DetectIntent WebHook Process", req, .rsp)
    $$$ThrowOnError(sc)

    // return processed response
    quit {
        "fulfillmentMessages": [{
            "text": {"text": [(rsp.text)]}
        }]
    }
}

}
