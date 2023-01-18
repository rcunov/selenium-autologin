# selenium-autologin
This is a *very* simple Docker container that automates logging in to a simple site with Selenium and Firefox. 

## Limitations
Currently, it only supports linux/amd64 architecture and a site with the login field named "username" and password field named "password". Obviously this is not a universal assumption, hence "*very* simple". This is more of a PoC than anything else, so I didn't include error handling or flesh it out more than basic functionality.

## Setup
Create a folder and create a new file called `.env` within it. Fill it out with your credentials and the site URL like:
```
SITE_USER=myUsername
SITE_PASS=myPassword
SITE_URL=https://example.com
```

## Run with Docker Compose
Download `compose.yml` to the folder with your `.env` file and run:
```
docker compose up -d
```

## Run with Docker CLI
From the folder with your `.env` file, run:
```
docker run --env-file .env --shm-size 2g rcunov/selenium-autologin
```

## Check status
`docker logs selenium-autologin` will show you the status of the container. The logs will show the output of any exceptions and if none occurred, they'll show a success message.