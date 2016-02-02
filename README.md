## Running Onedrive inside the docker container

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
# Download/clone this repo to your local machine. 

# Deploying docker image.

Build the docker image by running this command. 

```
make deploy
```

### Setup OneDrive container

After deploying with `make deploy` now you have onedrive image. To setup onedrive container follow these steps:

* Up onedrive container, use command `make onedrivedata `.
* Setup onedrive account by using command `make onedrive_configure`. Then following the steps.

```
[rischan@mbp /Volumes/RISCHAN/GITHUB/onedrive-docker (master)]$ make onedrivedata 

------------------------------------------------------------------
Running in OneDrive Container
------------------------------------------------------------------
Creating onedrive_data...
[rischan@mbp /Volumes/RISCHAN/GITHUB/onedrive-docker (master)]$ make onedrive_configure 

------------------------------------------------------------------
Configure onedrive
------------------------------------------------------------------
Loading configuration ... OK
[2016-02-02 00:01:13,556] DEBUG: thread_mgr: started.
Setting up onedrive-d...
(STEP 1/4) Do you want to authorize sign in with your OneDrive account? [Y/n]
```

* Start onedriave daemon by using command `make onedrive_startd`.
* If you need to stop onedrive daemon you can use command `make onedrive_stopd` or if you need to restart the daemon
you can use `make onedrive_restartd`.
* To check onedrive daemon status, whether onedrive daemon running or not you can use command `make onedrive_statusd`.

The onedrive application itself based on this project [https://github.com/xybu/onedrive-d-old](https://github.com/xybu/onedrive-d-old)
