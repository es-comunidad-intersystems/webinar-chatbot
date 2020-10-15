Class Chatbot.API.Telegram.spec Extends %REST.Spec [ ProcedureBlock ]
{

XData OpenAPI [ MimeType = application/json ]
{
{
  "swagger":"2.0",
  "info":{
    "description":"Receives an Update object from Telegram (WebHook)",
    "version":"1.0.0",
    "title":"Telegram WebHook API"
  },
  "basePath":"/chatbot/telegram",
  "tags":[
    {
      "name":"webhook",
      "description":"Receive updates from Telegram"
    }
  ],
  "schemes":[
    "https"
  ],
  "paths":{
    "/webhook":{
      "post":{
        "tags":[
          "webhook"
        ],
        "summary":"Process a Update object from Telegram",
        "description":"",
        "operationId":"processUpdate",
        "consumes":[
          "application/json"
        ],
        "produces":[
          "application/json"
        ],
        "parameters":[
          {
            "in":"body",
            "name":"body",
            "description":"Update object as in https://core.telegram.org/bots/api#update",
            "required":true,
            "schema":{
              "type":"object"
            }
          }
        ],
        "responses":{
          "200":{
            "description":"OK"
          },
          "500":{
            "description":"Internal Server Error"
          }
        }
      }
    }
  }
}
}

}
