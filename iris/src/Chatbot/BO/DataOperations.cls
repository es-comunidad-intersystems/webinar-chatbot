Class Chatbot.BO.DataOperations Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

/// Registers a user. Simulates the registration process of a user and linking to a patient.
Method registerUser(pRequest As Chatbot.Msg.RegisterUserReq, pResponse As Chatbot.Msg.RegisterUserRsp) As %Status
{
  set ret = $$$OK
  try {
    set pResponse = ##class(Chatbot.Msg.RegisterUserRsp).%New()

    set userObj = ##class(Chatbot.Data.User).UserIdKeyOpen(pRequest.userId)
    // -- create user
    if '$isobject(userObj) {
      set userObj = ##class(Chatbot.Data.User).%New()
      set userObj.userId = pRequest.userId
      // assign a patient number
      set userObj.patientNo = ##class(%PopulateUtils).SSN()
      // create some appointments
      // $$$ThrowOnError(##class(Chatbot.Data.Appointment).CreateRandomAppointments(userObj.patientNo, 1+$random(3)))
    }
    // -- update user
    set userObj.registered = 1
    set sc = userObj.%Save()
   
    // -- response
    set pResponse.user = userObj

    $$$ThrowOnError(sc)

  } catch ex {
    set ret = ex.AsStatus()
  }

  quit ret
}

/// Checks if a user is registered
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

/// Returns next appointments for a given patient
Method getNextAppointments(pRequest As Chatbot.Msg.GetNextApptReq, pResponse As Chatbot.Msg.GetNextApptRsp) As %Status
{
  set ret = $$$OK
  try {
      set pResponse = ##class(Chatbot.Msg.GetNextApptRsp).%New()
      set pResponse.apptList = ##class(%ListOfObjects).%New()

      set userObj = ##class(Chatbot.Data.User).UserIdKeyOpen(pRequest.userId)
      if $isobject(userObj) {
        set statement = ##class(%SQL.Statement).%New()
		    $$$ThrowOnError(statement.%Prepare("select apptdate, starttime, schedule from chatbot_data.appointment where patientno = ?"))
		    set result = statement.%Execute(userObj.patientNo)
        
        while result.%Next() {
			    set apptDate = result.%GetData(1)
          set startTime = result.%GetData(2)
          set schedule = result.%GetData(3)
          
          set apptTxt = $zdate(apptDate,4)_" "_$ztime(startTime,2)_" "_schedule
          do pResponse.apptList.Insert(apptTxt) 
        }
		
      }

  } catch ex {
    set ret = ex.AsStatus()
  }

  quit ret
}

/// Finds an appointment slot for some given conditions
Method findAppointmentSlot(pRequest As Chatbot.Msg.FindApptSlotReq, pResponse As Chatbot.Msg.FindApptSlotRsp) As %Status
{
  set ret = $$$OK
  try {
      set pResponse = ##class(Chatbot.Msg.FindApptSlotRsp).%New()
      set statement = ##class(%SQL.Statement).%New()
      $$$ThrowOnError(statement.%Prepare("select top 1 %id from chatbot_data.appointment where apptdate = ? and schedule = ? and patientno is null order by id"))
      set result = statement.%Execute(pRequest.apptDate, pRequest.schedule)
      
      while result.%Next() {
        set apptId = result.%GetData(1)
        set pResponse.appt = ##class(Chatbot.Data.Appointment).%OpenId(apptId) 
      }
    
  } catch ex {
    set ret = ex.AsStatus()
  }

  quit ret
}

/// Books an appointment slot for a patient
Method bookAppointmentSlot(pRequest As Chatbot.Msg.BookApptSlotReq, pResponse As Chatbot.Msg.BookApptSlotRsp) As %Status
{
  set ret = $$$OK
  try {
      set pResponse = ##class(Chatbot.Msg.BookApptSlotRsp).%New()
      set pResponse.done = 0

      // find user and appointment slot
      set userObj = ##class(Chatbot.Data.User).UserIdKeyOpen(pRequest.userId)
      set apptObj = ##class(Chatbot.Data.Appointment).%OpenId(pRequest.apptId)

      // udpate appointment slot and set user patient number
      if ($isobject(userObj) && $isobject(apptObj)) {
        if apptObj.PatientNo="" {
          set apptObj.PatientNo = userObj.patientNo
          set pResponse.appt = apptObj
          set pResponse.done = 1
        }
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
  <MapItem MessageType="Chatbot.Msg.GetNextApptReq">
    <Method>getNextAppointments</Method>
  </MapItem>
  <MapItem MessageType="Chatbot.Msg.FindApptSlotReq">
    <Method>findAppointmentSlot</Method>
  </MapItem>
  <MapItem MessageType="Chatbot.Msg.BookApptSlotReq">
    <Method>bookAppointmentSlot</Method>
  </MapItem>
</MapItems>
}

}
