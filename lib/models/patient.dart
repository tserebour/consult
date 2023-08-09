import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Human.dart';

class Patient extends Human {


  void getInfoFromHuman(Human user) {
    this.id = user.id;
    this.fullname = user.fullname;
    this.user_type = user.user_type;
    this.email = user.email;
  }


}


