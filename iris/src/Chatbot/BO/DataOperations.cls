Class Chatbot.BO.DataOperations Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method registerUser(pRequest As Chatbot.Msg.RegisterUserReq, pResponse As Chatbot.Msg.RegisterUserRsp) As %Status
{
  set ret = $$$OK
  try {

    set pResponse = ##class(Chatbot.Msg.RegisterUserRsp).%New()

    set userObj = ##class(Chatbot.Data.User).UserIdKeyOpen(pRequest.userId)
    if '$isobject(userObj) {
      set userObj = ##class(Chatbot.Data.User).%New()
      set userObj.userId = pRequest.userId
    }
    set userObj.registered = 1
    
    set sc = userObj.%Save()
    set pResponse.result = sc

    $$$ThrowOnError(sc)

  } catch ex {
    set ret = ex.AsStatus()
  }

  quit ret
}

Method isUserRegistered(pRequest As Chatbot.Msg.IsUserRegisteredReq, pResponse As Chatbot.Msg.IsUserRegisteredRsp) As %Status
{
  set ret = $$$OK
  try {
      
      set pResponse = ##class(Chatbot.Msg.IsUserRegisteredRsp).%New()
      set pResponse.registered = 0
      set pResponse.userId = pRequest.userId

      set userObj = ##class(Chatbot.Data.User).UserIdKeyOpen(pRequest.userId)
      if ($isobject(userObj) && (userObj.registered)) {
        set pResponse.registered = 1
      }

  } catch ex {
    set ret = ex.AsStatus()
  }

  quit ret
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Chatbot.Msg.RegisterUserReq">
    <Method>registerUser</Method>
  </MapItem>
  <MapItem MessageType="Chatbot.Msg.IsUserRegisteredReq">
    <Method>isUserRegistered</Method>
  </MapItem>
</MapItems>
}

}
