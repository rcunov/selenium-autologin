ARG ALPINE_VER

FROM python:3-alpine$ALPINE_VER

WORKDIR /app

# enable community repo and install system dependencies
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/community" >> /etc/apk/repositories \
	&& apk add --no-cache gcompat curl firefox-esr

# download proper geckodriver and put on PATH
RUN arch="$(uname -m)"; case "$arch" in aarch64) export CPU_TYPE='linux-aarch64' ;; x86_64) export CPU_TYPE='linux64' ;; esac; \
	curl -o geckodriver.tgz -sSL https://github.com/mozilla/geckodriver/releases/download/v0.32.0/geckodriver-v0.32.0-$CPU_TYPE.tar.gz \
	&& tar xzvf geckodriver.tgz -C /usr/local/bin && rm geckodriver.tgz

# copy files to workdir
COPY requirements.txt main.py ./

# install python dependencies
RUN pip3 install -r requirements.txt

# run with -u to print output to docker logs
CMD [ "python3", "-u", "./main.py" ]
