import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult/models/doctor.dart';
import 'package:consult/models/message.dart';
import 'package:consult/models/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Conversation{
  late Doctor doctor;
  late Patient patient;
  late String conversation_id;
  late List<Message> messages;


  FirebaseFirestore db = FirebaseFirestore.instance;

  Future getConversationInfoWithParticipantsIds() async {
    try {

      var conversation =  await db.collection('conversations')
          .where("patient_id", isEqualTo: "${patient.id}")
          .where("doctor_id", isEqualTo: "${doctor.id}")
          .get();

        return {
          "there_is_error": false,
          "data": conversation.docs
        };





    } catch(e) {
      return {
        "there_is_error": true,
        "data": e
      };

    }

  }

  addConversationToDatabase() async {

    try {

      var conversation =  await db.collection('conversations').add({
        "doctor_id": doctor.id,
        "patient_id": patient.id,
        "patient_name": patient.fullname,
        "doctor_name": doctor.fullname
      });


      conversation_id = conversation.id;





    } catch(e) {
      return {
        "there_is_error": true,
        "data": e
      };

    }

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages()  {



      var messages = db.collection('conversations')
          .doc(conversation_id)
          .collection('messages')
          .orderBy("timestamp", descending: false)
          .snapshots();



      return messages;


  }



}