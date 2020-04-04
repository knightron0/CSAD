fom flask import Flask, request, jsonify
import mysql.connector
#import cv2
import json
import gspread
from oauth2client.service_account import ServiceAccountCredentials

json_key = json.load(open('creds.json'))
scope = ['https://spreadsheets.google.com/feeds', 'https://www.googleapis.com/auth/drive', ]

credentials = ServiceAccountCredentials.from_json_keyfile_name("creds.json", scope)

gc = gspread.authorize(credentials) 
sheet = gc.open("RoadData").sheet1 


app = Flask(__name__)


@app.route('/', methods = ["GET", "POST"])
def dashboard():
    if request.method == "POST":
        longitude = ""
        latitude = ""
        time = ""
        print(request.headers)
        longitude = request.headers.get("long")[11:]
        longitude = longitude[:len(longitude)-1]
        latitude = request.headers.get("lat")[11:]
        latitude = latitude[:len(latitude)-1]
        time = request.headers.get("time")[11:]
        time = time[:len(time)-1]
        count = 1
        while sheet.acell('A' + str(count+1)).value != "":
            count += 1
        sheet.update_acell('A' + str(count+1), time)
        sheet.update_acell('B' + str(count+1), latitude)
        sheet.update_acell('C' + str(count+1), longitude)
        
    return "Nah, just a test run!"


@app.route("/check")
def check(methods = ["GET", "POST"]):
    return "none"
if __name__ == "__main__":
    app.run(host= "0.0.0.0")


