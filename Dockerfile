FROM python:3-slim-bullseye

WORKDIR /app

# install dependencies
RUN apt update && apt install -y curl firefox-esr && rm -rf /var/lib/apt/lists/*

# download geckodriver and put on PATH
RUN curl -o geckodriver.tgz -sSL https://github.com/mozilla/geckodriver/releases/download/v0.32.0/geckodriver-v0.32.0-linux64.tar.gz && tar xzvf geckodriver.tgz -C /usr/local/bin && rm geckodriver.tgz

COPY requirements.txt .

COPY main.py .

RUN pip3 install -r requirements.txt

# run with -u to print output to docker logs
CMD [ "python3", "-u", "./main.py" ]
