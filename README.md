

# GCP
## Compute Engine. VM
* Region: us-central1
* Config: E2 e2-medium (2 vCPU, 4GB)
* OS: Ubuntu 16.04 LTS
* Identity & API access: Allow full access to Cloud APIs
*Firewall: HTTP, HTTPS

Install Docker
```
sudo apt update
sudo apt install docker.io
sudo apt install docker-compose
```

Clone repo
```
git config --global credential.helper cache
git clone https://github.com/albertoft/iris-chatbot
```

Get InterSystems images
```
sudo docker pull store/intersystems/iris-community:2020.2.0.211.0
sudo docker login -u="user" -p="token" containers.intersystems.com
sudo docker pull containers.intersystems.com/intersystems/webgateway:2020.2.0.211.0
```

Set IRIS password
Create a file called `.env` in the repository root directory, like: 
```
ISC_PASSWORD=somepassword
```

Build & run
```
docker-compose build
docker-compose up -d
```