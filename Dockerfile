FROM python:3-alpine$ALPINE_VER

WORKDIR /app

# enable community repo and install system dependencies
ARG ALPINE_VER=3.17
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/community" >> /etc/apk/repositories \
	&& apk add --no-cache gcompat curl firefox

# download proper geckodriver and put on PATH
ARG GECKO_VER=0.33.0
RUN arch="$(uname -m)"; case "$arch" in aarch64) export CPU_TYPE='linux-aarch64';; x86_64) export CPU_TYPE='linux64';; esac; \
	curl -o geckodriver.tgz -sSL https://github.com/mozilla/geckodriver/releases/download/v${GECKO_VER}/geckodriver-v${GECKO_VER}-$CPU_TYPE.tar.gz \
	&& tar xzvf geckodriver.tgz -C /usr/local/bin && rm geckodriver.tgz

# copy files to workdir
COPY requirements.txt main.py ./

# install python dependencies
RUN pip3 install -r requirements.txt

# run with -u to print output to docker logs
CMD [ "python3", "-u", "./main.py" ]
