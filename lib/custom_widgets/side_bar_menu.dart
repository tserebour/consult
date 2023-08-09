import 'package:consult/models/patient.dart';
import 'package:consult/pages/about_doctor_page.dart';
import 'package:consult/pages/launchpage.dart';
import 'package:flutter/material.dart';

import '../models/Human.dart';

class SideBarMenu extends StatefulWidget {
  Human human;
  SideBarMenu( {required this.human, Key? key}) : super(key: key);

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {

  bool darkModeSwitch = false;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children:  [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: ClipOval(

                  child: Image.network(
                    'https://cdn.theatlantic.com/thumbor/hMBZ9JAZ5MAmdUaLutU2hrR0QzQ=/0x90:2880x1710/976x549/media/img/mt/2016/01/superman/original.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,

                  ),

                ),

              ),
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://i.pinimg.com/originals/f2/cc/d1/f2ccd1e7d4bb50f14404a2c83173fc6b.jpg',

                      ),
                      fit: BoxFit.cover
                  )
              ),
              accountName: Text(
                  widget.human.fullname,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20

                ),
              ),
              accountEmail: Text(
                  widget.human.email,
                style: const TextStyle(
                    color: Colors.white,

                    fontSize: 15

                ),
              )
          ),
          const ListTile(
            leading: Icon(
                Icons.group
            ),
            title: Text(
                'Patience'
            ),



          ),

          const ListTile(
            leading: Icon(
                Icons.list
            ),
            title: Text(
                'Doctors'
            ),



          ),
          const Divider(
            thickness: 2,
          ),

          const ListTile(
            leading: Icon(
                Icons.settings
            ),
            title: Text(
                'settings'
            ),



          ),

          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: SwitchListTile(
              activeColor: Colors.green,
              title: const Text('Dark Mode'),

              onChanged: (bool value) {


                setState(() {

                  darkModeSwitch ? darkModeSwitch = false : darkModeSwitch = true;

                });

              },
              value: darkModeSwitch,

            ),
          ),


          InkWell(
            onTap: (){
              widget.human.logout().then((value){

                });



            },
            child: const ListTile(
              leading: Icon(
                  Icons.logout
              ),
              title: Text(
                  'Profile'
              ),
            ),
          ),


           InkWell(
            onTap: () async {
              await widget.human.logout().then((value){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LaunchPage()),
                );
              });


            },
            child: const ListTile(
              leading: Icon(
                Icons.logout
              ),
              title: Text(
                'Logout'
              ),
            ),
          )


    ],
      ),

    );



  }
}
