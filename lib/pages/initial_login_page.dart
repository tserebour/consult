
import 'package:consult/models/Human.dart';
import 'package:flutter/Material.dart';

import 'login_page.dart';


class InitialLoginPage extends StatelessWidget {
   InitialLoginPage({Key? key}) : super(key: key);


  Human user = Human();

  @override
  Widget build(BuildContext context) {






    return  Scaffold(
      body: Container(

        decoration:  const BoxDecoration(
          color: Colors.blue,

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
            const SizedBox(height: 60,),
            const Padding(
              padding: EdgeInsets.all(20.0),


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Consult',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40
                    ),
                  ),

                  Text(
                    'Welcome',
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

                            InkWell(
                              onTap: (){

                                user.user_type = "Doctor";

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  LoginPage(user: user)),
                                );



                              },
                              child: Container(
                                height: 50,

                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(Radius.circular(20))


                                ),
                                child:  const Center(
                                  child: Text(
                                    'As a Doctor',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 60,),
                            InkWell(
                              onTap: (){

                                user.user_type = "Patient";

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  LoginPage(user: user,)),
                                );



                              },
                              child: Container(
                                height: 50,

                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(Radius.circular(20))


                                ),
                                child:  const Center(
                                  child: Text(
                                    'As a Patient',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                            ),




                          ],
                        ),

                      ),

                      const SizedBox(height: 40,),



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
}
