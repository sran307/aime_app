import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Biometric {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    try {
      bool canCheckBiometrics = await _auth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        // Biometrics not available, fallback to pattern lock authentication
        return false;
      }

      bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to access the app',
        // biometricOnly: true, // Only allow biometric authentication
      );
      return authenticated;
    } catch (e) {
      print('Error authenticating with biometrics: $e');
      return false;
    }
  }
}