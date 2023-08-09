import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult/models/Human.dart';
import 'package:image_picker/image_picker.dart';

class Message{
  String content = "";
  String timestamp = "";
  late Human sender;
  String message_id = "";
  String conversation_id = "";
  List<XFile>attachments = [];



}