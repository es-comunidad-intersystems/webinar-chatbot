

# GCP
## Compute Engine. VM
* Region: us-central1
* Config: E2 e2-medium (2 vCPU, 4GB)
* OS: Ubuntu 16.04 LTS
* Identity & API access: Allow full access to Cloud APIs
* Firewall: HTTP, HTTPS
* Register External IP
* Google Domains + Google Cloud DNS

https://irischatbot.voidpointer.dev/csp/sys/UtilHome.csp
http://104.198.164.179/csp/sys/UtilHome.csp

### Install Docker
```
sudo apt update
sudo apt install docker.io
sudo apt install docker-compose
```

### Clone repo
```
git config --global credential.helper cache
git clone https://github.com/albertoft/iris-chatbot
```

### Let's encrypt SSL Certificate
https://certbot.eff.org/lets-encrypt/ubuntuxenial-apache

Install certbot
```
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

Run certbot in standalone mode (temporary http server is run)
```
sudo certbot certonly --standalone --preferred-challenges http -d irischatbot.voidpointer.dev
```

Copy certificate files into webgateway context (required for building):
```
sudo cp /etc/letsencrypt/live/irischatbot.voidpointer.dev/fullchain.pem webgateway/ssl-cert.pem
sudo cp /etc/letsencrypt/live/irischatbot.voidpointer.dev/privkey.pem webgateway/ssl-cert.key
```                   

### Get InterSystems images
```
sudo docker pull store/intersystems/iris-community:2020.2.0.211.0
sudo docker login -u="user" -p="token" containers.intersystems.com
sudo docker pull containers.intersystems.com/intersystems/webgateway:2020.2.0.211.0
```

### Set IRIS password
Create a file called `.env` in the repository root directory, like: 
```
ISC_PASSWORD=somepassword
```

### Build & run
```
docker-compose build
docker-compose up -d
```


# IRIS

REST API created using ^%REST (it is already built in the image):
```
CHATBOT>do ^%REST

REST Command Line Interface (CLI) helps you CREATE or DELETE a REST application.
Enter an application name or (L)ist all REST applications (L): L

Applications        Web Applications
------------        ----------------

Enter an application name or (L)ist all REST applications (L): Chatbot.API.DialogFlow
REST application not found: Chatbot.API.DialogFlow
Do you want to create a new REST application? Y or N (Y): Y

File path or absolute URL of a swagger document.
If no document specified, then create an empty application.
OpenAPI 2.0 swagger: /shared/chatbot-dialogflow-api.json 

OpenAPI 2.0 swagger document: /shared/chatbot-dialogflow-api.json
Confirm operation, Y or N (Y): Y

-----Creating REST application: Chatbot.API.DialogFlow-----
CREATE Chatbot.API.DialogFlow.spec
GENERATE Chatbot.API.DialogFlow.disp
CREATE Chatbot.API.DialogFlow.impl
REST application successfully created.

Create a web application for the REST application? Y or N (Y): Y
Specify a web application name beginning with a single '/'. Default is /csp/Chatbot/API/DialogFlow
Web application name: /chatbot/dialogflow

-----Deploying REST application: Chatbot.API.DialogFlow-----
Application Chatbot.API.DialogFlow deployed to /chatbot/dialogflow
```