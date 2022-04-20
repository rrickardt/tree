from flask import Flask
from waitress import serve
from prometheus_flask_exporter import PrometheusMetrics

server = Flask(__name__)
metrics = PrometheusMetrics(server)

@server.route("/tree")
def app():
    return {'favourite tree':'pinus mugo'}

if __name__ == "__main__":
    serve(server, host="0.0.0.0", port=5000)
