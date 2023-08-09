import 'package:consult/models/Human.dart';
import 'package:consult/models/patient.dart';
import 'package:consult/pages/about_doctor_page.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/side_bar_menu.dart';
import '../models/doctor.dart';
import 'conversations_screen.dart';
import 'initial_login_page.dart';

class HomePage extends StatefulWidget {
  Human user;
  HomePage({Key? key,required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

var selectedDoctor;

@override


  @override
  Widget build(BuildContext context) {




      return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Consultation')),
        ),
        drawer:  SideBarMenu(human: widget.user),

        body:  SafeArea(
          child: Column(
            children: [

              //search row
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){

                        }, icon: const Icon(Icons.search)


                    ),

                    const Expanded(
                        child: TextField(

                          decoration: InputDecoration(
                              hintText: "Doctor's name",
                              hintStyle: TextStyle(
                                color: Colors.grey,

                              ),
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.all(Radius.circular(30))

                              )
                          ),

                        )
                    )
                  ],
                ),
              ),

              ////////////////////
              // category text


              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(

                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20

                    ),
                  ),
                ),
              ),

              ///category row
              ///
              const SizedBox(height: 20,),

              Container(
                height: 80,
                child:  ListView(
                  scrollDirection: Axis.horizontal,


                  children: [
                    Container(
                      width: 100,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(

                          borderRadius: BorderRadius.circular(8),
                          child: const Placeholder(
                            color: Colors.black,


                          ),
                        ),
                      ),
                    ),


                    Container(
                      width: 100,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(

                          borderRadius: BorderRadius.circular(8),
                          child: const Placeholder(
                            color: Colors.black,


                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 100,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(

                          borderRadius: BorderRadius.circular(8),
                          child: const Placeholder(
                            color: Colors.black,


                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 100,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(

                          borderRadius: BorderRadius.circular(8),
                          child: const Placeholder(
                            color: Colors.black,


                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 100,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(

                          borderRadius: BorderRadius.circular(8),
                          child: const Placeholder(
                            color: Colors.black,


                          ),
                        ),
                      ),
                    ),











                  ],
                ),
              ),

              const SizedBox(height: 20,),

              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(

                    'Top Rated Doctors',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20

                    ),
                  ),
                ),
              ),



              StreamBuilder(
                  stream: widget.user.getDoctorsList(),

                builder: (context, snapshot) {

                    if(snapshot.hasData){
                      var docs = snapshot.data?.docs;
                      print(docs?[0].data());


                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(



                              children: docs!.map<Widget>((doc){
                                 return InkWell(
                                   onTap: (){

                                     selectedDoctor = doc.data();


                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => AboutDoctorPage(user: widget.user, doctor: selectedDoctor)),
                                     );



                                   },
                                   child: Padding(
                                    padding: const EdgeInsets.all(10.0),

                                    child: ListTile(

                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      ),

                                      tileColor: Colors.grey,

                                      leading:  const CircleAvatar(
                                        backgroundImage: NetworkImage(""),
                                        radius: 20,
                                      ),

                                      title:  Text(
                                        "Dr. ${doc['fullname'] ?? ''}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      subtitle:  Text(doc['doctor_type'] ??''),
                                      trailing: Text(
                                        doc['location'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),


                                    ),
                                ),
                                 );

                              }).toList(),
                      )

                  )
                  );






                  }else if(snapshot.hasError){
                      print("iejfi");

                    }


                  return const Center(child: CircularProgressIndicator());



                  // var docs = snapshot.data.docs;

                }
              ),






            ],
          ),
        ),




      );





  }


}
