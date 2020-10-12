Class Chatbot.BO.DialogFlowDetectIntent Extends EnsLib.REST.Operation
{

Parameter INVOCATION = "Queue";

Method detectIntent(pRequest As Chatbot.Msg.DetectIntentReq, Output pResponse As Chatbot.Msg.DetectIntentRsp) As %Status
{
    set ret = $$$OK
    try {
        set pResponse = ##class(Chatbot.Msg.DetectIntentRsp).%New()

        // request URL
        set url = ..Adapter.URL_"/"_pRequest.session_"?access_token="_pRequest.tokenValue

        // request body
        set body = { 
            "queryInput": {
                "text": {
                    "text": (pRequest.text),
                    "languageCode": (pRequest.lang)
                }
            }
        }

        $$$LOGINFO(url)

        // send POST request
        set sc = ..Adapter.PostURL(url, .httpRsp, "", body.%ToJSON())
		if $$$ISERR(sc),$isobject(httpRsp),$isobject(httpRsp.Data),httpRsp.Data.Size {
            return $$$ERROR($$$EnsErrGeneral,$$$StatusDisplayString(sc)_":"_httpRsp.Data.Read())
        }
        $$$ThrowOnError(sc)
        
        // handle response
        if $isobject(httpRsp) {
            set formatter = ##class(%JSON.Formatter).%New()
            do formatter.FormatToStream(httpRsp.Data.Read(), .formatted)
            set pResponse.raw = formatted

            // instantiate response in json dynamic object & grab some properties
            //set jsonRsp = {}.%FromJSON(httpRsp.Data.Read()) 
        }

   } catch ex {
       set ret = ex.AsStatus()
   }
   quit ret
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Chatbot.Msg.DetectIntentReq">
    <Method>detectIntent</Method>
  </MapItem>
</MapItems>
}

}