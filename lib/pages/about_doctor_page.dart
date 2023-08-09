import 'package:consult/models/Human.dart';
import 'package:consult/models/conversation.dart';
import 'package:consult/models/patient.dart';
import 'package:flutter/material.dart';

import '../models/doctor.dart';
import 'dm_screen.dart';

class AboutDoctorPage extends StatelessWidget {
    late Human user;
    late var doctor;
    Conversation conversation = Conversation();
    var patient = Patient();
   AboutDoctorPage({Key? key, required  this.user, required  this.doctor}) : super(key: key);


  @override
  Widget build(BuildContext context) {




    return Scaffold(

      // backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,

      ),
      body:  SafeArea(
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage('image_url'),
                radius: 80,
              ),
            ),


            // //////////////////////////////////////////////////////////////////
            
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.blue,


                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                              'Dr. ${doctor["fullname"]}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),
                          ),

                          Text(
                            doctor["doctor_type"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                           Text(
                            doctor["location"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                ),
              ),
            ),
            ////////////////////////////////////////////////////////////////////////////////////////////////



            ////]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

             Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 4),
              child: Column(
                children: [
                  Container(
                    child:  Row(

                      children: [


                           const Text(
                            'About',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3,),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () async {


                                      Doctor doctor = Doctor();
                                      doctor.getDataFromMap(this.doctor);

                                      patient.getInfoFromHuman(user);
                                      conversation.patient = patient;
                                      conversation.doctor = doctor;

                                      var conversation_info = await conversation.getConversationInfoWithParticipantsIds();
                                      var data_from_conversation_info = conversation_info['data'];

                                      if(data_from_conversation_info.length < 1) {
                                        await conversation.addConversationToDatabase().then((value){

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => DMScreen(sender: user, receiver: doctor, conversation: conversation)),
                                          );

                                        });

                                      }else{

                                        conversation.conversation_id = data_from_conversation_info[0].id;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DMScreen(sender: user, receiver: doctor, conversation: conversation)),
                                        );

                                      }











                                   },

                                   icon: const Icon(Icons.message),

                                  ),

                                IconButton(
                                  onPressed: (){

                                  },

                                  icon: const Icon(Icons.call),

                                ),

                                IconButton(
                                  onPressed: (){

                                  },

                                  icon: const Icon(Icons.video_call),

                                ),
                              ],
                            ),
                            ),
                          ),



                      ],

                    ),
                  ),

                   Text(
                  doctor["about"],
                    style: const TextStyle(
                      fontSize: 15
                    ),
                  )
                ],
              ),
            ),

            ////]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]


            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.blue,


                  child:   Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                                Text(
                                  '65',
                                  style: TextStyle(
                                    color: Colors.white

                                  ),
                                ),
                              Text(
                                'Patients',
                                style: TextStyle(
                                    color: Colors.white

                                ),
                              )

                            ],
                          ),
                        ),
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                '6 years',
                                style: TextStyle(
                                    color: Colors.white

                                ),
                              ),
                              Text(
                                'Experience',
                                style: TextStyle(
                                    color: Colors.white

                                ),
                              )

                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                doctor["rating"].toString(),

                                style: const TextStyle(
                                    color: Colors.white

                                ),
                              ),
                              const Text(
                                'Ratings',
                                style: TextStyle(
                                    color: Colors.white

                                ),
                              )

                            ],
                          ),
                        )
                      ],
                    )
                  ),

                ),
              ),
            ),


            //////////////////////////////////////////////////////////////////////////////

          ],
        ),

      ),
    );
  }
}
