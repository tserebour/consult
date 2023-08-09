import 'package:consult/models/patient.dart';
import 'package:flutter/material.dart';

import '../models/Human.dart';
import '../models/authentication.dart';
import 'conversations_screen.dart';
import 'homepage.dart';
import 'initial_login_page.dart';
import 'login_page.dart';


class LaunchPage extends StatefulWidget {


  static const routeName = "/";

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {

  late Human user;


  @override



  void dialogBox(String message){

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content:  Text(message),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Cancel'),
          //   child: const Text('Cancel'),
          // ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => InitialLoginPage()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );



  }

  Future<void> loadPreferences() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();


    user = Human();
    await user.getUserInfoFromSharedPreference();

    var loggedIn = user.logged_in;





    print(loggedIn);


    if(loggedIn == false || loggedIn == null) {



      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  InitialLoginPage()),
        );
      });




    }else{



      var value = await Authenticator.authenticate('Authenticate to access the app');

      if(value == true) {


        if(user.user_type == "Doctor"){
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ConversationsScreen(user: user)),
            );
          });

        }else{
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(user: user)),
            );
          });
        }
















      }else{

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LaunchPage()),
        );

      }




    }


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consult',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue[600], // Set the scaffold background color
      ),
      home: FutureBuilder(
        future: loadPreferences(),
        builder: (context, snapshot) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Consult',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set the text color to white

                    ),
                  ),
                  SizedBox(height: 30),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

