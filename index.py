import base64

sha1_hex = "3C:9F:C4:68:34:B7:41:25:8D:8D:B2:1A:B3:7A:3D:AB:4B:E1:01:AD"
key_hash = base64.b64encode(bytes.fromhex(sha1_hex.replace(":", ""))).decode()
print(key_hash)