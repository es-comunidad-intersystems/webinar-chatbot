Class Chatbot.BO.GoogleTranslate Extends EnsLib.REST.Operation
{

Parameter INVOCATION = "Queue";

/// Google Cloud Credentials (API key)
Property GoogleCloudCredentials As %String;

/// These are the production settings for this object
Parameter SETTINGS = "GoogleCloudCredentials:Basic:credentialsSelector";

/// translate text from a source (optional) language to a target language
Method translate(pRequest As Chatbot.Msg.TranslateReq, Output pResponse As Chatbot.Msg.TranslateRsp) As %Status
{
    set ret = $$$OK
    try {
        set pResponse = ##class(Chatbot.Msg.TranslateRsp).%New()

        // retrieve credentials
        set sc = ##class(Ens.Config.Credentials).GetCredentialsObj(.credObj, $classname(), "Ens.Config.Credentials", ..GoogleCloudCredentials)
        $$$ThrowOnError(sc)

        // request URL
        set url = ..Adapter.URL_"?key="_credObj.Password
        
        // request body
        set body = { 
            "q": [(pRequest.text)],
            "source": (pRequest.sourceLang),
            "target": (pRequest.targetLang)
        }

        // send POST request
        set sc = ..Adapter.PostURL(url, .httpRsp, "", body.%ToJSON())
		if $$$ISERR(sc),$isobject(httpRsp),$isobject(httpRsp.Data),httpRsp.Data.Size {
            return $$$ERROR($$$EnsErrGeneral,$$$StatusDisplayString(sc)_":"_httpRsp.Data.Read())
        }
        $$$ThrowOnError(sc)
        
        // handle response
        if $isobject(httpRsp) {
            set formatted = ""
            set formatter = ##class(%JSON.Formatter).%New()
            do formatter.FormatToStream(httpRsp.Data, .formatted)
            set pResponse.raw = formatted

            // instantiate response in json dynamic object
            set jsonRsp = {}.%FromJSON(formatted)
            // get first translation
            set pResponse.translatedText = jsonRsp.data.translations.%Get(0).translatedText
        }

   } catch ex {
       set ret = ex.AsStatus()
   }
   quit ret
}

/// detect language from a given text
Method detect(pRequest As Chatbot.Msg.DetectLanguageReq, Output pResponse As Chatbot.Msg.DetectLanguageRsp) As %Status
{
    set ret = $$$OK
    try {
        set pResponse = ##class(Chatbot.Msg.DetectLanguageRsp).%New()

        // retrieve credentials
        set sc = ##class(Ens.Config.Credentials).GetCredentialsObj(.credObj, $classname(), "Ens.Config.Credentials", ..GoogleCloudCredentials)
        $$$ThrowOnError(sc)

        // request URL
        set url = ..Adapter.URL_"/detect?key="_credObj.Password
        
        // request body
        set body = { 
            "q": [(pRequest.text)]
        }

        // send POST request
        set sc = ..Adapter.PostURL(url, .httpRsp, "", body.%ToJSON())
		if $$$ISERR(sc),$isobject(httpRsp),$isobject(httpRsp.Data),httpRsp.Data.Size {
            return $$$ERROR($$$EnsErrGeneral,$$$StatusDisplayString(sc)_":"_httpRsp.Data.Read())
        }
        $$$ThrowOnError(sc)
        
        // handle response
        if $isobject(httpRsp) {
            set formatted = ""
            set formatter = ##class(%JSON.Formatter).%New()
            do formatter.FormatToStream(httpRsp.Data, .formatted)
            set pResponse.raw = formatted

            // instantiate response in json dynamic object
            set jsonRsp = {}.%FromJSON(formatted)
            // get first detection
            set pResponse.language = jsonRsp.data.detections.%Get(0).%Get(0).language
            set pResponse.confidence = jsonRsp.data.detections.%Get(0).%Get(0).confidence
            set pResponse.isReliable = jsonRsp.data.detections.%Get(0).%Get(0).isReliable
        }

   } catch ex {
       set ret = ex.AsStatus()
   }
   quit ret
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Chatbot.Msg.TranslateReq">
    <Method>translate</Method>
  </MapItem>
  <MapItem MessageType="Chatbot.Msg.DetectLanguageReq">
    <Method>detect</Method>
  </MapItem>
</MapItems>
}

}
