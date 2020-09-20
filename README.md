# nginx proxy

* you can run whichever [webapps-via-docker](https://github.com/salmanwaheed/webapps-via-docker) you like and follow steps
* nginx proxy would work on all cloud providers (AWS, GCP, Azure or etc), and localhost if you have same network

* usage:
```yml
---
version: '3.7'
services:
  .....
  environment:
    ....
    VIRTUAL_HOST: app1.example.com
    VIRTUAL_PORT: 9000
---
version: '3.7'
services:
  .....
  environment:
    ....
    VIRTUAL_HOST: app2.example.com
    VIRTUAL_PORT: 9001
```
