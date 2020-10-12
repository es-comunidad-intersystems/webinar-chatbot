Class Chatbot.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Chatbot.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Setting Target="Adapter" Name="ShutdownTimeout">20</Setting>
  <Item Name="Google Auth Token Oper" Category="" ClassName="EnsLib.PEX.BusinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="%gatewayPort">55555</Setting>
    <Setting Target="Host" Name="%gatewayHost">jgw</Setting>
    <Setting Target="Host" Name="%remoteClassname">com.intersystems.google.OAuth2Operation</Setting>
    <Setting Target="Host" Name="%remoteSettings">CredentialsFile=/credentials/google-credentials.json</Setting>
  </Item>
</Production>
}

}
