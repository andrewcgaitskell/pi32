from app import init_app
import pickle
application = init_app()

from urllib.parse import urlparse, urlunparse, quote

from pprint import pformat
from time import time

import requests
import chardet

import json
import ast
import chardet
from datetime import datetime

import io

import os
import sys
from os import environ, path
from dotenv import load_dotenv

BASE_DIR = path.abspath(path.dirname(__file__))
load_dotenv(path.join(BASE_DIR, "/app/.env"))

print('BASE_DIR')
print(BASE_DIR)

from app.baseapp.app import app as app1

app = init_app()   

application = DispatcherMiddleware(app, {
    '/python/baseapp': app1.server,
})  

