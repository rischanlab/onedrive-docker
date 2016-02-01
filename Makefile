PROJECT_ID := onedrive

SHELL := /bin/bash

# ----------------------------------------------------------------------------
#    P R O D U C T I O N     C O M M A N D S
# ----------------------------------------------------------------------------
run: build permissions

deploy: run 
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Bringing up fresh instance "
	@echo "------------------------------------------------------------------"

build:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building in production mode"
	@echo "------------------------------------------------------------------"
	@docker-compose -p $(PROJECT_ID) build

permissions:
	# Probably we want something more granular here....
	# Your sudo password will be needed to set the file permissions
	# on logs, media, static and pg dirs
	@if [ ! -d "logs" ]; then mkdir logs; fi
	@if [ ! -d "onedrive" ]; then mkdir onedrive; fi
	@if [ ! -d "data" ]; then mkdir data; fi
	@if [ -d "logs" ]; then sudo chmod -R a+rwx logs; fi
	@if [ -d "onedrive" ]; then sudo chmod -R a+rwx onedrive; fi
	@if [ -d "data" ]; then sudo chmod -R a+rwx data; fi


kill:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Killing in production mode"
	@echo "------------------------------------------------------------------"
	@docker-compose -p $(PROJECT_ID) kill

rm: kill
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Removing production instance!!! "
	@echo "------------------------------------------------------------------"
	@docker-compose -p $(PROJECT_ID) rm

shell:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Shelling in in production mode"
	@echo "------------------------------------------------------------------"
	@docker-compose -p $(PROJECT_ID) run data /bin/bash

onedrivedata:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in OneDrive Container"
	@echo "------------------------------------------------------------------"
	@docker-compose -p $(PROJECT_ID) up --no-deps -d onedrivedata

onedrive_helpd:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running Onedrive daemon Help"
	@echo "------------------------------------------------------------------"
	@docker exec -t -i $(PROJECT_ID)_data onedrive-d

onedrive_configure:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Configure onedrive"
	@echo "------------------------------------------------------------------"
	@docker exec -t -i $(PROJECT_ID)_data onedrive-pref

onedrive_statusd:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Knowing Onedrive daemon status"
	@echo "------------------------------------------------------------------"
	@docker exec -t -i $(PROJECT_ID)_data onedrive-d status

onedrive_startd:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running Onedrive daemon"
	@echo "------------------------------------------------------------------"
	@docker exec -t -i $(PROJECT_ID)_data onedrive-d start

onedrive_stopd:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Stopping Onedrive daemon"
	@echo "------------------------------------------------------------------"
	@docker exec -t -i $(PROJECT_ID)_data onedrive-d stop

onedrive_restartd:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Restarting Onedrive daemon"
	@echo "------------------------------------------------------------------"
	@docker exec -t -i $(PROJECT_ID)_data onedrive-d restart