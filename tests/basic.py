import requests

def test_api_value():
    req = requests.get('http://localhost:5000/tree')
    assert req.json()['favourite tree'] == 'pinus mugo'
