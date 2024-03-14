import hashlib

def hashUsername(input_string):
    # Convert input string to bytes (UTF-8 encoding)
    input_bytes = input_string.encode('utf-8')
    
    # Calculate MD5 hash
    md5_hash = hashlib.md5(input_bytes)
    
    # Get hexadecimal representation of the hash
    md5_hex = md5_hash.hexdigest()
    
    return md5_hex


def hashPassword(password, username, iterations=7):
    # Concatenate password and username
    concatenated_string = password + username

    # Hash the concatenated string using SHA-256 multiple times
    hashed_result = concatenated_string.encode('utf-8')
    for _ in range(iterations):
        hashed_result = hashlib.sha256(hashed_result).digest()

    # Convert the final hashed result to hexadecimal representation
    hashed_password = hashlib.sha256(hashed_result).hexdigest()

    return hashed_password
