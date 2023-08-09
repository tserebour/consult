import 'package:consult/models/patient.dart';
import 'package:flutter/material.dart';

import '../models/Human.dart';
import '../pages/homepage.dart';



class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {





    return BottomAppBar(





        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.home,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context) => HomePage(user: Human()),
                    ),
                  );

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                icon: Icon(
                  Icons.group,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ContactsScreen(),
                  //   ),
                  // );

                },
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                elevation: 8,
                focusColor: Colors.green,
                splashColor: Colors.green,
                child: Icon(
                  Icons.payment,
                ),
                onPressed: () {
                  print(ModalRoute.of(context)?.settings.name);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(),
                  //   ),
                  // );

                },
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                icon: Icon(
                  Icons.list,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TransactionHistoryScreen(),
                  //   ),
                  // );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfileScreen(),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      );

  }
}
