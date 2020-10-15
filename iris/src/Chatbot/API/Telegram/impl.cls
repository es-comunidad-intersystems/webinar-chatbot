/// Receives an Update object from Telegram (WebHook)<br/>
/// Business logic class defined by OpenAPI in Chatbot.API.Telegram.spec<br/>
/// Created Oct 15, 2020 15:50:24
Class Chatbot.API.Telegram.impl Extends (%REST.Impl, Ens.BusinessService) [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Process a Update object from Telegram<br/>
/// The method arguments hold values for:<br/>
///     body, Update object as in https://core.telegram.org/bots/api#update<br/>
ClassMethod processUpdate(body As %DynamicObject) As %DynamicObject
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object

    // instantiate Business Service (interoperability framework)
    set sc = ##class(Ens.Director).CreateBusinessService("Chatbot.API.Telegram.impl",.service)
    $$$ThrowOnError(sc)

    // build request message
    set formatter = ##class(%JSON.Formatter).%New()
    do formatter.FormatToStream(body, .formatted)
    
    set req = ##class(Ens.StreamContainer).%New()
    set req.Stream = formatted
    
    // send message to Business Operation
    set sc = service.SendRequestAsync("Dummy", req, .rsp)
    $$$ThrowOnError(sc)

    quit { "status": "OK" }
}

}
