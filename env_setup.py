#!/usr/bin/python3

import os
import urllib3
import json
import base64

http = urllib3.PoolManager()

# Set up variables
app = os.environ['APP']
env = os.environ['APP_ENV']
consul_url = os.environ['CONSUL_URL']
base_url = consul_url + '/v1/kv'
parent_key = app + "/" + env + "/"

url = base_url + '/' + app + '/' + env + '/?recurse'


response = http.request('GET', url)
data = json.loads(response.data.decode("utf-8"))

for env_data in data:
    if env_data['Value'] != None:
        key = str.replace(env_data['Key'], parent_key, "")
        value = base64.b64decode(env_data['Value']).decode("utf-8")
        print(key + "," + value+"~")