import 'package:encrypt/encrypt.dart';


class EcryptDecrypt{



   static String encrypt(text){
     final iv = IV.fromLength(16);
     final encrypter = Encrypter(AES(Key.fromLength(32)));

     return encrypter.encrypt(text, iv: iv).base64;



  }



   static String decrypt(String base64Text) {
     final iv = IV.fromLength(16);
     final encrypter = Encrypter(AES(Key.fromLength(32)));

    String decrypted = encrypter.decrypt(Encrypted.fromBase64(base64Text), iv: iv);

    return decrypted;
  }


}