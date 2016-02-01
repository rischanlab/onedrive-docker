## Running Onedrive Ubuntu inside the docker container

## Build your docker images and run them

You can simply run the provided script and it will build and deploy the docker
images for you.

Before start to run this docker you have to:

Create onedrive account, then make new application. After that you will get application client ID 
and app client secret. Change the value of APP_CLIENT_ID and APP_CLIENT_SECRET in `docker-compose.yml` with yours.


```
- APP_CLIENT_ID=0000000040172910
- APP_CLIENT_SECRET=WAltBcwM9B3nlGDmplOUGfPLqsw5bHDA

```

Deploying docker image.

```
make deploy
```

### Setup OneDrive container

After deploying with `make deploy` now you have onedrive image. To setup onedrive container follow these steps:

* Up onedrive container, use command `make onedrivedata `.
* Setup onedrive account by using command `make onedrive_configure`. Then following the steps.
* Start onedriave daemon by using command `make onedrive_startd`.
* If you need to stop onedrive daemon you can use command `make onedrive_stopd` or if you need to restart the daemon
you can use `make onedrive_restartd`.
* To check onedrive daemon status, whether onedrive daemon running or not you can use command `make onedrive_statusd`.
