
import 'package:consult/models/Human.dart';
import 'package:consult/pages/about_doctor_page.dart';
import 'package:consult/pages/chat_page.dart';
import 'package:consult/pages/homepage.dart';
import 'package:consult/pages/launchpage.dart';
import 'package:consult/pages/login_page.dart';
import 'package:consult/pages/slide_show.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {





    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consult',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.blue,
      ),
      // ThemeData
      home:  Ongoing(),
      // initialRoute: '/login_page',
      routes: const {
        // LaunchPage.routeName: (context) => LaunchPage(),
        // HomePage.routeName: (context) => HomePage(),
        // TransactionHistoryScreen.routeName: (context) => TransactionHistoryScreen(),
        // SignUpPage.routeName: (context) => SignUpPage(),
        // LoginPage.routeName: (context) => LoginPage(),



      },
    ); // MaterialApp
  }
}