Class Chatbot.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Chatbot.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Setting Target="Adapter" Name="ShutdownTimeout">20</Setting>
  <Item Name="Google Auth Token Oper" Category="User Input/Output" ClassName="EnsLib.PEX.BusinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="%gatewayPort">55555</Setting>
    <Setting Target="Host" Name="%gatewayHost">jgw</Setting>
    <Setting Target="Host" Name="%remoteClassname">com.intersystems.google.OAuth2Operation</Setting>
    <Setting Target="Host" Name="%remoteSettings">CredentialsFile=/credentials/google-credentials.json</Setting>
  </Item>
  <Item Name="DialogFlow DetectIntent" Category="User Input/Output" ClassName="Chatbot.BO.DialogFlowDetectIntent" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">dialogflow.googleapis.com</Setting>
    <Setting Target="Adapter" Name="SSLConfig">SSL</Setting>
    <Setting Target="Adapter" Name="URL">/v2</Setting>
  </Item>
  <Item Name="DetectIntent Process" Category="User Input/Output" ClassName="Chatbot.BP.DetectIntentProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Chatbot.API.DialogFlow.impl" Category="DialogFlow Fullfillment" ClassName="Chatbot.API.DialogFlow.impl" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Chatbot.API.Telegram.impl" Category="User Input/Output" ClassName="Chatbot.API.Telegram.impl" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Telegram SendMessage" Category="User Input/Output" ClassName="Chatbot.BO.TelegramSendMessage" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="HTTPServer">api.telegram.org</Setting>
    <Setting Target="Adapter" Name="SSLConfig">SSL</Setting>
    <Setting Target="Host" Name="TelegramCredentials">TelegramBot</Setting>
  </Item>
  <Item Name="Data Operations" Category="User Input/Output,DialogFlow Fullfillment" ClassName="Chatbot.BO.DataOperations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Telegram WebHook Process" Category="User Input/Output" ClassName="Chatbot.BP.TelegramWebHookProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DetectIntent WebHook Process" Category="DialogFlow Fullfillment" ClassName="Chatbot.BP.DetectIntentWebHookProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Google Translate" Category="User Input/Output" ClassName="Chatbot.BO.GoogleTranslate" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="URL">https://translation.googleapis.com/language/translate/v2</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="SSLConfig">SSL</Setting>
    <Setting Target="Host" Name="GoogleCloudCredentials">GoogleTranslate</Setting>
  </Item>
</Production>
}

}
