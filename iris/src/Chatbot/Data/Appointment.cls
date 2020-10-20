Class Chatbot.Data.Appointment Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor)
{

Property Schedule As %String;

Property ApptDate As %Date;

Property StartTime As %Time;

Property EndTime As %Time;

Property UniversalService As %String;

Property Doctor As %String;

Property PatientNo As %String;

/// Create appointment slots
/// write ##class(Chatbot.Data.Appointment).CreateSlots()
ClassMethod CreateSlots(pStartDate As %Date = {+$h}, pEndDate As %Date = {+$h+5})
{
    #define RandomItem(%list) $lg(%list, 1+$random($listlength(%list)))

    set ret = $$$OK
	try {
		$$$ThrowOnError(..%DeleteExtent())
		
		set scheduleList = $lb("Psicología","Dermatología","Cardiología")
		set drList = $lb("Dr. Campos","Dr. González","Dr. Sagé i Pau","Dra. Toro","Dr. Zamora")
		set serviceList = $lb("Primera Visita","Revisión")
		
		set startTime=$ztimeh("08:00",2)
		set endTime=$ztimeh("18:00",2)
		set duration=(15*60)
		
		for apptDate=pStartDate:1:pEndDate {
			for apptTime=startTime:duration:endTime {
				set tObj=..%New()
				set tObj.ApptDate=apptDate
				set tObj.StartTime=apptTime
				set tObj.EndTime=apptTime + duration
				set tObj.Schedule=$$$RandomItem(scheduleList) 
				set tObj.Doctor=$$$RandomItem(drList)
				set tObj.UniversalService=$$$RandomItem(serviceList)

				$$$ThrowOnError(tObj.%Save())
			}	
		}
	} catch ex {
		set ret = ex.AsStatus()
	}
	quit ret
}

/// Create random appointments for a given patient
/// write ##class(Chatbot.Data.Appointment).CreateRandomAppointments(123)
ClassMethod CreateRandomAppointments(pPatientNo As %String = "", pNumAppointments As %Integer = 1) As %Status
{
	set ret = $$$OK
	try {
		// get max row
		set statement = ##class(%SQL.Statement).%New()
		$$$ThrowOnError(statement.%Prepare("select max(%id) from Chatbot_Data.Appointment"))
		set result = statement.%Execute()

		if result.%Next() {
			set maxRow = result.%GetData(1)
			// create random appointments
			for i=1:1:pNumAppointments {
				set rowId = 1 + $random(maxRow)
				set updateStatement = ##class(%SQL.Statement).%New()
				$$$ThrowOnError(updateStatement.%Prepare("update Chatbot_Data.Appointment set patientNo=? where %id=? and patientNo is null"))
				set updateResult = updateStatement.%Execute(pPatientNo, rowId)
			}
        }
	} catch ex {
		set ret = ex.AsStatus()
	}
	quit ret
}

Storage Default
{
<Data name="AppointmentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Schedule</Value>
</Value>
<Value name="3">
<Value>ApptDate</Value>
</Value>
<Value name="4">
<Value>StartTime</Value>
</Value>
<Value name="5">
<Value>EndTime</Value>
</Value>
<Value name="6">
<Value>UniversalService</Value>
</Value>
<Value name="7">
<Value>Doctor</Value>
</Value>
<Value name="8">
<Value>PatientNo</Value>
</Value>
</Data>
<DataLocation>^Chatbot.Data.AppointmentD</DataLocation>
<DefaultData>AppointmentDefaultData</DefaultData>
<IdLocation>^Chatbot.Data.AppointmentD</IdLocation>
<IndexLocation>^Chatbot.Data.AppointmentI</IndexLocation>
<StreamLocation>^Chatbot.Data.AppointmentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
