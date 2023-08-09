

import 'package:local_auth/local_auth.dart';

class Authenticator{




  static Future<bool> authenticate(String message) async {
    final LocalAuthentication localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();


        bool isAuthenticated = await localAuth.authenticate(
          localizedReason: message,

        );

        if (isAuthenticated) {
          //
          return true;

        } else {
          return false;
        }





    } else {
      return false;
    }
  }

}