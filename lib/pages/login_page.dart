import 'dart:convert';


import 'package:consult/models/Human.dart';
import 'package:consult/pages/conversations_screen.dart';
import 'package:consult/pages/signup_page.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/custom_input.dart';
import '../models/patient.dart';
import 'homepage.dart';



class LoginPage extends StatefulWidget {
  late Human user;
  
  LoginPage({Key? key, required this.user}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = "";
  String _password = '';
  String _afterclick = 'Login';

  String selected_user_type = "";

  void usernameCallBackFunction(String data){
    setState(() {
      email = data;
    });
  }

  void passwordCallBackFunction(String data){
    setState(() {
      _password = data;
    });
  }



  @override
  Widget build(BuildContext context) {

    selected_user_type = widget.user.user_type;
    print(widget.user.user_type);
    return  Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
          color: Colors.blue

            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   colors: [
            //     Colors.purple,
            //     Colors.blue,
            //   ],
            //
            //   // end: Alignment.topRight,
            // )

        ),

        // height: MediaQuery.of(context).size.height*0.4,
        width: double.infinity,
        // alignment: Alignment.bottomLeft,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(height: 80,),
            const Padding(
              padding: EdgeInsets.all(20.0),


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      fontSize: 40
                    ),
                  ),

                  Text(
                    'Welcome Back',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                ],
              ),

            ),
            SizedBox(height: 60,),

            Expanded(


                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                      color: Colors.white,

                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            const SizedBox(height: 20,),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0,10)


                                  )

                                ]
                              ),
                              child: Column(
                                children: [
                                  CustomInput(hint_text: 'Email', callback: usernameCallBackFunction, obcureText: false,),
                                  CustomInput(hint_text: 'Password', callback: passwordCallBackFunction, obcureText: true,),

                                ],
                              ),

                            ),

                            const SizedBox(height: 40,),
                            InkWell(
                              onTap: () async {
                                print(email);
                                print(_password);



                                setState(() {

                                  _afterclick = 'Logging in....';

                                });


                                widget.user.email = email;
                                widget.user.password = _password;
                                
                                await widget.user.login().then((value) async {
                                  var response = value;
                                  bool there_is_error = response["there_is_error"];

                                  if(there_is_error == false){
                                    var userDataFromAuth = response['userDataFromAuth'];

                                    widget.user.id = userDataFromAuth.user.uid;
                                    widget.user.user_type = 'Patient';

                                    var userInfoFromDatabase = response["userInfoFromDatabase"];

                                    widget.user.fullname = userInfoFromDatabase["fullname"];
                                    widget.user.user_type = userInfoFromDatabase["user_type"];


                                      widget.user.logged_in = true;



                                      await widget.user.setUserInfoToSharedPreference().then((value){

                                        if(widget.user.user_type == "Patient"){

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>  HomePage(user: widget.user),
                                            ),
                                          );

                                        }else{
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>  ConversationsScreen(user: widget.user),
                                            ),
                                          );
                                        }



                                      });







                                  }else{

                                    var error_message = response['error'];

                                    dialogBox(error_message.toString());
                                    setState(() {
                                      _afterclick = 'Login';
                                    });

                                  }
                                });









                              },
                              child: Container(
                                height: 50,

                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(20))


                                ),


                                child:  Center(
                                  child: Text(
                                    _afterclick,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  )



                                ),
                              ),
                            ),

                            const SizedBox(height: 30,),
                            InkWell(
                              child: const Text("Don't have an Account? Register here."),
                              onTap: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(user: widget.user),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),



                  ),
                )

          ],
        ),



      ),
    );
  }





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
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );



  }

}

