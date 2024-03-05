import base64
import json
import hashlib

def decode_data(encoded_data):
    # Decode base64 data
    decoded_bytes = base64.b64decode(encoded_data)
    decoded_str = decoded_bytes.decode('utf-8')
    
    # Parse JSON
    decoded_data = json.loads(decoded_str)
    
    return decoded_data

def verify_checksum(data, received_checksum):
    # Generate checksum from received data
    calculated_checksum = hashlib.md5(json.dumps(data).encode()).hexdigest()
    
    # Compare checksums
    if calculated_checksum == received_checksum:
        return True
    else:
        return False