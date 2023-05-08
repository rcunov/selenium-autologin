from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import os
import time
from datetime import datetime, timezone

# docker environment variables
username = os.environ['SITE_USER']
password = os.environ['SITE_PASS']
site = os.environ['SITE_URL']

def login():
    # set options
    fireFoxOptions = webdriver.FirefoxOptions()
    fireFoxOptions.add_argument('--headless')

    # start browser
    browser = webdriver.Firefox(options=fireFoxOptions)

    # open the page
    browser.get(site)

    # fill username field
    username_field = browser.find_element(By.NAME, 'username')
    username_field.send_keys(username)

    # fill password field
    password_field = browser.find_element(By.NAME, 'password')
    password_field.send_keys(password + Keys.RETURN)

    # wait for page to load
    time.sleep(3)

    # bye bye
    browser.close()

    # print message if script runs without exception
    # doesn't actually verify success but this is a simple, generic script
    ugly_timestamp = datetime.now(timezone.utc)
    pretty_timestamp = ugly_timestamp.strftime('%Y-%m-%d_%H:%M:%S')
    print("Successful login on %s UTC" % pretty_timestamp)

if __name__ == "__main__":
    login()
