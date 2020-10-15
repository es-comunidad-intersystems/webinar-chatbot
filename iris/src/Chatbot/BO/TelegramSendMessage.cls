Class Chatbot.BO.TelegramSendMessage Extends EnsLib.REST.Operation
{

Parameter INVOCATION = "Queue";

/// Telegram Bot Credentials (Token)
Property TelegramCredentials As %String;

/// These are the production settings for this object
Parameter SETTINGS = "TelegramCredentials:Basic:credentialsSelector";

Method sendMessage(pRequest As Chatbot.Msg.TelegramMsgReq, Output pResponse As Chatbot.Msg.TelegramMsgRsp) As %Status
{
    set ret = $$$OK
    try {
        set pResponse = ##class(Chatbot.Msg.TelegramMsgRsp).%New()

        // retrieve credentials
        set sc = ##class(Ens.Config.Credentials).GetCredentialsObj(.credObj, $classname(), "Ens.Config.Credentials", ..TelegramCredentials)
        $$$ThrowOnError(sc)

        // request URL
        set url = ..Adapter.URL_"/bot"_credObj.Password_"/sendMessage?chat_id="_pRequest.chatId_"&text="_pRequest.text

        // send GET request
        set sc = ..Adapter.GetURL(url, .httpRsp, "", "")
        if $$$ISERR(sc),$isobject(httpRsp),$isobject(httpRsp.Data),httpRsp.Data.Size {
            return $$$ERROR($$$EnsErrGeneral,$$$StatusDisplayString(sc)_":"_httpRsp.Data.Read())
        }
        $$$ThrowOnError(sc)
        
        // handle response
        if $isobject(httpRsp) {
            set formatter = ##class(%JSON.Formatter).%New()
            do formatter.FormatToStream(httpRsp.Data, .formatted)
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
  <MapItem MessageType="Chatbot.Msg.TelegramMsgReq">
    <Method>sendMessage</Method>
  </MapItem>
</MapItems>
}

}
