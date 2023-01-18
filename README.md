# selenium-autologin
This is a *very* simple Docker container that automates logging in to a simple site with Selenium and Firefox. 

## Limitations
Currently, it only supports the x64 arch and a site with the login field named "username" and password field named "password". Obviously this is not a universal assumption, hence "*very* simple". This is more of a PoC than anything else, so I didn't include error handling or flesh it out more than basic functionality.

## Setup
Clone the repository and create a new file called `.env` in the folder. Fill it out with your credentials and the site URL like:
```
SITE_USER=myUsername
SITE_PASS=myPassword
SITE_URL=https://example.com
```

## Run with Docker Compose
```
docker compose up -d
```

## Run with Docker CLI
```
docker build --tag=selenium-autologin .
docker run --env-file .env --shm-size 2g selenium-autologin
