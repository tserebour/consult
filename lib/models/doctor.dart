import 'package:consult/models/patient.dart';

import 'Human.dart';

class Doctor extends Human {

  String doctor_type = "";
  String location = "";
  String about = "";
  int experience = 0;
  double rating = 0;

  Doctor(){
    this.user_type = "Doctor";
  }


  getDataFromMap(Map data){

    doctor_type = data["doctor_type"] ?? '';
    location = data["location"] ?? '';
    rating = double.parse(data["rating"].toString()) ?? 0.0;
    experience = data["experience"] ?? 0;
    about = data["about"] ?? '';
    fullname = data["fullname"] ?? '';
    id = data["id"] ?? '';
    user_type = data["user_type"] ?? '';
    email = data["email"] ?? '';


  }

}