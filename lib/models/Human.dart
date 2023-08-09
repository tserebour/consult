import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult/models/encrypt_decrypt.dart';
import 'package:consult/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Human{

  String fullname  = "";
  String email = "";
  String password = "";
  String id = '';
  String user_type = '';
  bool logged_in = false;
  FirebaseAuth firebase_auth =FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();


  Future<void>getUserInfoFromSharedPreference() async {
    print("Getting user info from shared preference");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    logged_in = prefs.getBool('logged_in') ?? false;
     id = prefs.getString("id") ?? '';
    fullname = prefs.getString('fullname')?? '';
    email = prefs.getString('email')?? '';
    user_type = prefs.getString('user_type')?? '' ;



    print('done loading');



  }

  Future<dynamic> register() async {
    try {
      var userData = await firebase_auth.createUserWithEmailAndPassword(email: this.email, password: this.password);
       id = userData.user?.uid ?? '';
      await db.collection('users').doc(id).set({
        "fullname": fullname,
        "email": email,

        "id": id,
        "user_type": user_type

      });
      return {
        "there_is_error": false,
        "userData": userData
      };

    }on FirebaseAuthException catch(e) {
      return {
        "there_is_error": true,
        "error": e
      };

    }



  }

  Future<dynamic> login() async {

    try {
      var userDataFromAuth = await firebase_auth.signInWithEmailAndPassword(email: this.email, password: this.password);
      id = userDataFromAuth.user?.uid ?? '';
      var userInfoFromDatabase = await db.collection('users').doc(id).get();
      if(userInfoFromDatabase.data()?['user_type'] == user_type){
        return {
          "there_is_error": false,
          "userDataFromAuth": userDataFromAuth,
          "userInfoFromDatabase": userInfoFromDatabase.data()
        };

      }else{
        return {
          "there_is_error": true,
          "userDataFromAuth": userDataFromAuth,
          "userInfoFromDatabase": userInfoFromDatabase.data()
        };
      }



    }on FirebaseAuthException catch(e) {
      return {
        "there_is_error": true,
        "error": e
      };

    }




  }
  Future<dynamic> logout() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("logged_in") ;
    await prefs.remove("id") ;
    await prefs.remove("email") ;
    await prefs.remove("fullname") ;
    await prefs.remove("user_type") ;

  }

  Future<void>setUserInfoToSharedPreference() async {
    print("Setting user info from shared preference");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("logged_in", logged_in) ;
    await prefs.setString("id", id) ;
    await prefs.setString("email", email) ;
    await prefs.setString("fullname", fullname) ;
    await prefs.setString("user_type", user_type) ;





  }
  
  Stream<QuerySnapshot<Map<String, dynamic>>> getDoctorsList() {

      var data =  db.collection('users')
          .where("user_type", isEqualTo: "Doctor")
          .snapshots();



      return  data;










  }

  Future sendMessage(Message message) async {
    // print(message.sender.id);

    try {

      List attachmentPaths  = [];






      for (int i = 0; i < message.attachments.length; i++){


        String filePath = message.attachments[i].path;

        File file = File(filePath);
        var fileToStore = storageRef.child('attachments/${message.conversation_id}_${DateTime. now()}');

        await fileToStore.putFile(file);
        print("link: ${await fileToStore.getDownloadURL()}");

        String downloadLink = await fileToStore.getDownloadURL();
        attachmentPaths.add(downloadLink);



      }


      print(attachmentPaths);


      var messageToBeSent = db.collection('conversations')
          .doc(message.conversation_id)
          .collection("messages")
          .add({
              "sender_id" : message.sender.id,
              "content" : EcryptDecrypt.encrypt(message.content),
              "timestamp" : FieldValue.serverTimestamp(),
              "attachments": attachmentPaths


          });




      return messageToBeSent;

    }  catch (error){
      print(error);

    }



  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversations()  {
    String s = "patient_id";
    if(this.user_type == "Doctor"){
      s = "doctor_id";

    }

    var messages = db.collection('conversations')
        .where(s, isEqualTo: id)
        .snapshots();






    return messages;


  }

}