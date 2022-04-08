from flask import Flask
from waitress import serve

server = Flask(__name__)

@server.route("/tree")
def app():
    return {'favourite tree':'pinus mugo'}

if __name__ == "__main__":
    serve(server, host="0.0.0.0", port=5000)
