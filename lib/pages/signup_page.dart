import 'package:flutter/material.dart';
import '../custom_widgets/custom_input.dart';
import '../models/Human.dart';
import '../models/patient.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  late Human user;
  SignUpPage({Key? key, required this.user}) : super(key: key);
  static const routeName = "/Sign_up";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String fullname = '';
  String _email = '';
  String _password = '';
  String _confirmpassword = '';
  String _afterclick = 'Sign Up';

  String special_password = 'Tinsters';
  String special_password_input = '';








  void usernameCallBackFunction(String data){
    setState(() {
      fullname = data;
    });
  }

  void passwordCallBackFunction(String data){
    setState(() {
      _password = data;
    });
  }

  void confirmPasswordCallBackFunction(String data){
    setState(() {
      _confirmpassword = data;
    });
  }

  void emailCallBackFunction(String data){
    setState(() {
      _email = data;
    });
  }




  @override
  Widget build(BuildContext context) {
    print(widget.user.user_type);


    return  Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
          color: Colors.blue,

            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   colors: [
            //     // Colors.purple,
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
            const SizedBox(height: 60,),
            const Padding(
              padding: EdgeInsets.all(20.0),


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40
                    ),
                  ),

                  Text(
                    'Register Here',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                ],
              ),

            ),
            const SizedBox(height: 40,),

            Expanded(


              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                  color: Colors.white,

                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(children: [

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
                              CustomInput(hint_text: 'Fullname', callback: usernameCallBackFunction, obcureText: false,),
                              CustomInput(hint_text: 'Email', callback: emailCallBackFunction, obcureText: false),
                              CustomInput(hint_text: 'Password', callback: passwordCallBackFunction, obcureText: true),
                              CustomInput(hint_text: 'Confirm Password', callback: confirmPasswordCallBackFunction, obcureText: true),

                              // Container(
                              //   decoration: const BoxDecoration(
                              //       border: Border(bottom: BorderSide(color: Colors.grey))
                              //   ),
                              //   child:  DropdownButton <String> (
                              //     value: _selected_account_type,
                              //     onChanged: ( value) {
                              //       setState(() {
                              //         _selected_account_type = value!;
                              //
                              //       });
                              //
                              //     },
                              //     items: account_types.
                              //       map(
                              //               (item) =>
                              //                   DropdownMenuItem<String>(
                              //                     value: item,
                              //                     child: Text(item),
                              //                   )
                              //
                              //
                              //     ).toList()
                              //
                              //
                              //
                              //   )
                              //
                              // )
                            ],
                          ),

                        ),

                        const SizedBox(height: 40,),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _afterclick = 'Signing Up....';
                            });




                            if(_password.isNotEmpty && fullname.isNotEmpty && _email.isNotEmpty){

                              if(_password.length > 7){

                                if(_password == _confirmpassword){

                                  widget.user.fullname = fullname;
                                  widget.user.email = _email;
                                  widget.user.password = _password;



                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Input Special Password'),
                                      content:   TextField(
                                        obscureText: true,
                                        onChanged: (value){
                                          special_password_input = value;



                                        },

                                      ),
                                      actions: <Widget>[
                                        // TextButton(
                                        //   onPressed: () => Navigator.pop(context, 'Cancel'),
                                        //   child: const Text('Cancel'),
                                        // ),
                                        TextButton(
                                          onPressed: () {
                                            if(special_password_input == special_password){
                                              Navigator.pop(context, 'OK');



                                              widget.user.register().then((value){
                                                print(value);
                                                var response = value;
                                                var there_is_error = response['there_is_error'];
                                                if(there_is_error == false){

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>  LoginPage(user: widget.user,),
                                                    ),
                                                  );

                                                }else{

                                                  var error_message = response['error'];

                                                  dialogBox(error_message.toString());
                                                  setState(() {
                                                    _afterclick = 'Sign Up';
                                                  });

                                                }

                                              });





                                            }else{

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>  LoginPage(user: widget.user,),
                                                ),
                                              );

                                            }
                                          } ,
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );




















                                }else{
                                  dialogBox('Password not confirmed');

                                  setState(() {
                                    _afterclick = 'Sign Up';
                                  });


                                }

                              }else{
                                dialogBox('Password length is too short');

                                setState(() {
                                  _afterclick = 'Sign Up';
                                });
                              }


                            }else{
                              dialogBox('All Fields are required');

                              setState(() {
                                _afterclick = 'Sign Up';
                              });

                            }






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
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        InkWell(
                            child: const Text('Login instead'),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  LoginPage(user: widget.user,),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),



              ),
            ),


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











