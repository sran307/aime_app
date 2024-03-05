import 'dart:convert';
import 'package:crypto/crypto.dart';

class encryptor {
  Map<String, dynamic> encryptedData = <String, dynamic>{};

  Future<void> encrypt(data) async {
    var _encryptedData = <String, dynamic>{};

    String base64Data = encodeDataToBase64(data);
    String checksum = generateChecksum(jsonEncode(data));
    print("encodedData: $base64Data");
    print("Checksum: $checksum");

    encryptedData = <String, dynamic>{
      "encodedData": "$base64Data",
      "Checksum": "$checksum"
    };


  }

  String encodeDataToBase64(Map<String, dynamic> data) {
    // Encode data to JSON
    String jsonData = jsonEncode(data);

    // Encode JSON data to base64
    String base64Data = base64Encode(utf8.encode(jsonData));

    return base64Data;
  }

  String generateChecksum(String jsonData) {
    // Compute MD5 checksum
    var bytes = utf8.encode(jsonData); // data being hashed
    var digest = md5.convert(bytes);

    return digest.toString();
  }

    Map<String, dynamic> get _encryptedData => encryptedData;
}
