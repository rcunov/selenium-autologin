#!/bin/bash

# purpose of this script 

# declare vars
WAIT_TIME=1 # $(shuf -i 0-10 -n 1)  # selects a pseudo-random number from 0-10
ENV_FILE=.env
SITE_URL=$(cat $ENV_FILE | grep SITE_URL | rev | cut -f 1 -d '=' | rev)  # grabs the value of SITE_URL
									 # from the env file declared above
# announce sleep in case script is run interactively
echo "Waiting for $WAIT_TIME seconds..."

sleep $WAIT_TIME && echo "Logging in to $SITE_URL" \
	&& docker run --env-file $ENV_FILE --shm-size 2g rcunov/selenium-autologin | tee -a log.txt
