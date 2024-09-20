import os
import psycopg2
import json

from flask import Flask
from flask.json import jsonify

myhost = os.uname()[1]

app = Flask(__name__)
app.config['JSON_SORT_KEYS'] = False
os.chdir(os.path.dirname(os.path.abspath(__file__)))

def postgres_test():
    with open('config.json', 'r') as f:
        config = json.load(f)
    try:
        conn = psycopg2.connect(f"dbname={config['dbname']} user={config['user']} host={config['host']} password={config['password']}")
        conn.close()
        return 'Successful connection to DB'
    except:
        return 'Error connection to DB'


@app.route("/")
def index():
    db_status = postgres_test()
    return jsonify(
        host=myhost,
        db_status=db_status
    )
