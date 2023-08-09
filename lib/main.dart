



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult/models/Human.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';

import 'models/patient.dart';
import 'myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options:  DefaultFirebaseOptions.currentPlatform
  );








  // String email = 'test@example.com';
  // String password = '12345678';
  // var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  // UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  // print(userCredential.user?.uid);


  // EcryptDecrypt encrypt =  EcryptDecrypt();
  // var encrypted = encrypt.encrypt('hello world');
  // print(encrypted);
  //
  // var decrypted = encrypt.decrypt(encrypted);
  // print(decrypted);
  runApp(const MyApp());

}


