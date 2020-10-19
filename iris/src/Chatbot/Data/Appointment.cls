Class Chatbot.Data.Appointment Extends (%Persistent, %JSON.Adaptor)
{

Property Schedule As %String;

Property ApptDate As %Date;

Property StartTime As %Time;

Property EndTime As %Time;

Property UniversalService As %String;

Property Doctor As %String;

Property ApptUser As User;

ClassMethod CreateSlots(pStartDate As %Date = {+$h-1}, pEndDate As %Date = {+$h+10})
{
    #define RandomItem(%list) $lg(%list, 1+$random($listlength(%list)))

    set ret = $$$OK
	try {
		$$$ThrowOnError(..%DeleteExtent())
		
		set scheduleList = $lb("Andrología","Cardiología","Ginecología","Traumatología","Urología")
		set drList = $lb("Campos,Dr.","González,Dr.","Sagé i Pau,Dr.","Toro,Dra.","Zamora,Dr.")
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
<Value>ApptUser</Value>
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
