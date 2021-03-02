import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:butom_navbar/auth_helper.dart';


class Main_Drawer extends StatefulWidget {
  @override
  _Main_DrawerState createState() => _Main_DrawerState();
}

class _Main_DrawerState extends State<Main_Drawer> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.black54,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width * 0.2,
                  // height: MediaQuery.of(context).size.height * 0.2,
                  child: Text(
                    'Welcome to Virtual Hospital',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      // color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                UserAccountsDrawerHeader(accountName: Text("${user?.displayName}"), accountEmail: Text("${user?.email}"))
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Emergency'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              AuthHelper.logOut();
            },
          )
        ],
      ),
    );
  }
}
