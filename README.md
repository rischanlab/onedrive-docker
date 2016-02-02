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
### Download/clone this repo to your local machine. 

### Deploying docker image.

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
You will need to visit the OneDrive sign-in page in a browser, 
log in and authorize onedrive-d, and then copy and paste the 
callback URL, which should start with 
"https://login.live.com/oauth20_desktop.srf".

The callback URL is the URL where the sign-in page finally goes blank.

Please visit the sign-in URL in your browser:

https://login.live.com/oauth20_authorize.srf?redirect_uri=https%3A%2F%2Flogin.live.com%2Foauth20_desktop.srf&display=touch&scope=wl.skydrive+wl.skydrive_update+wl.offline_access&locale=en&client_id=Blabla&response_type=code

```

```
Please paste the callback URL:
https://login.live.com/oauth20_desktop.srf?code=M33f2cd2e-c76b-60cd-2233-sdsdasd&lc=1033

[2016-02-02 00:12:47,735] DEBUG: MainThread: config saved.
onedrive-d has been successfully authorized.

(STEP 2/4) Do you want to specify path to local OneDrive repository? [Y/n] Y
Please enter the abs path to sync with your OneDrive (default: /root/OneDrive): 
[2016-02-02 00:12:51,054] DEBUG: MainThread: config saved.
Path successfully set.

(STEP 3/4) Do you want to change the numeric settings? [Y/n] n
Skipped.

(STEP 4/4) Do you want to edit the ignore list file? [Y/n] n
Skipped. You can manually edit "/root/.onedrive/ignore_v2.ini" at your convenience.

All steps are finished.
[2016-02-02 00:12:55,126] DEBUG: Dummy-2: config saved.

```
* Start onedriave daemon by using command `make onedrive_startd`.
* If you need to stop onedrive daemon you can use command `make onedrive_stopd` or if you need to restart the daemon
you can use `make onedrive_restartd`.
* To check onedrive daemon status, whether onedrive daemon running or not you can use command `make onedrive_statusd`.

```
[rischan@mbp /Volumes/RISCHAN/GITHUB/onedrive-docker (master *)]$ make onedrive_startd 

------------------------------------------------------------------
Running Onedrive daemon
------------------------------------------------------------------
Loading configuration ... OK
[2016-02-02 00:13:13,852] DEBUG: MainThread: running in daemon node.
Starting onedrive-d ... OK
[rischan@mbp /Volumes/RISCHAN/GITHUB/onedrive-docker (master *)]$ make onedrive_statusd 

------------------------------------------------------------------
Knowing Onedrive daemon status
------------------------------------------------------------------
Loading configuration ... OK
[2016-02-02 00:13:17,761] DEBUG: MainThread: running in daemon node.
onedrive-d -- pid: 51, status: sleeping, uptime: 0m, %cpu: 0.0, %mem: 1.4
```

Then you will see that all your data in your onedrive account will be syncronized inside the `data` directory.

The onedrive application itself based on this project [https://github.com/xybu/onedrive-d-old](https://github.com/xybu/onedrive-d-old)
