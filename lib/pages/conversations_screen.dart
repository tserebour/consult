import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult/models/Human.dart';
import 'package:consult/models/conversation.dart';
import 'package:flutter/Material.dart';

import '../custom_widgets/side_bar_menu.dart';
import 'dm_screen.dart';

class ConversationsScreen extends StatefulWidget {

  late Human user;
  ConversationsScreen({Key? key, required  this.user}) : super(key: key);

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  var selectedConversation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Center(child: Text('Consultation')),
      ),
      drawer:  SideBarMenu(human: widget.user),
      body: SafeArea(
        child: StreamBuilder(
          stream: widget.user.getConversations(),
          builder: (context, snapshot) {

            if(snapshot.hasData){
              return ListView(
                children: snapshot.data!.docs.map<Widget>((doc){

                  return  InkWell(
                    onTap: (){
                      selectedConversation = doc;
                      Conversation conversation = Conversation();
                      conversation.conversation_id = doc.id;

                      Human other_user = Human();

                      if(widget.user.user_type == "Doctor"){
                        other_user.user_type = "Patient";
                      }else{
                        other_user.user_type = "Doctor";
                      }
                      other_user.fullname = doc.data()[other_user.user_type == "Patient" ? "patient_name" : "doctor_name"] ?? "";
                      other_user.id = doc.data()[other_user.user_type == "Patient" ? "patient_id" : "doctor_id"] ?? "";


                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DMScreen(sender: widget.user, receiver: other_user, conversation: conversation)),
                      );
                    },
                    child: ListTile(

                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20)
                      // ),

                      tileColor: Colors.white12,

                      leading: const Icon(Icons.person,),
                      // CircleAvatar(
                      //
                      //   backgroundImage: NetworkImage('image_url'),
                      //   radius: 20,
                      // ),

                      title: Text(
                        "${widget.user.user_type == 'Doctor'? doc.data()['patient_name'] : doc.data()['doctor_name']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: const Text('last message'),
                      trailing: const Text(
                        'Last seen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),


                    ),
                  );

                }).toList(),

              );

            }else{
              return Container();
            }

          }
        ),
      ),

    );
  }
}
