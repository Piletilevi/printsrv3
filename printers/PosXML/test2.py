import requests

url = "http://192.168.2.45:4445/"

payload = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<PosXML version=\"7.2.0\">\n\t<ReadCardRequest>\n\t</ReadCardRequest>\n</PosXML>"
headers = {
    'content-type': "application/xml",
    'cache-control': "no-cache",
    'postman-token': "a8a65a56-1298-5183-af1f-ab57a721626f"
    }

response = requests.request("POST", url, data=payload, headers=headers)

print(response.text)

payload = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<PosXML version=\"7.2.0\">\n\t<CancelAllOperationsRequest>\n\t</CancelAllOperationsRequest>\n</PosXML>"
headers = {
    'content-type': "application/xml",
    'cache-control': "no-cache",
    'postman-token': "daa27726-7ab0-e383-d02e-013abe215fcf"
    }

response = requests.request("POST", url, data=payload, headers=headers)

print(response.text)