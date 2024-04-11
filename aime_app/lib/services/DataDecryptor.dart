import 'dart:convert';
import 'package:crypto/crypto.dart';

class decryptor {
  Map<String, dynamic> decryptedData = <String, dynamic>{};

  Future<Map<String, dynamic>> decrypt(data) async {
    var _decryptedData = <String, dynamic>{};

    String decodedString = utf8.decode(base64.decode(data));
    Map<String, dynamic> jsonData = json.decode(decodedString);

    decryptedData = <String, dynamic>{
      "decodedData": "$jsonData",
    };

    return jsonData;
  }

  Map<String, dynamic> get _decryptedData => decryptedData;
}
