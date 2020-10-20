Class Chatbot.DT.GetNextApptRsp2DetectIntentWebHookRsp Extends Ens.DataTransformDTL [ DependsOn = (Chatbot.Msg.GetNextApptRsp, Chatbot.Msg.DetectIntentWebHookRsp) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Chatbot.Msg.GetNextApptRsp' targetClass='Chatbot.Msg.DetectIntentWebHookRsp' create='new' language='objectscript' >
<foreach property='source.apptList()' key='k1' >
<assign value='target.text_$char(10)_source.apptList.GetAt(k1)' property='target.text' action='set' />
</foreach>
</transform>
}

}
