// // import 'package:butom_navbar/nav_button/admin_or_user.dart';
// // import 'buttom_bar.dart';
// // import 'package:butom_navbar/loginpage/newaccount.dart';
// // import 'package:butom_navbar/onboarding/onboarding.dart';
// import 'package:butom_navbar/admin/admin_or_user.dart';
// import 'package:butom_navbar/admin/home.dart';
// import 'package:butom_navbar/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'loginpage/signin.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // primarySwatch: Colors.blue,
//       ),
//       home: MainScreen(),
//     );
//   }
// }
//
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if(snapshot.hasData && snapshot.data != null) {
//             UserHelper.saveUser(snapshot.data);
//             return StreamBuilder(
//               stream: FirebaseFirestore.instance.collection("users").doc(snapshot.data.uid).snapshots(),
//               builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
//                 if(snapshot.hasData && snapshot.data != null){
//                   final user = snapshot.data.data();
//                   if(user['role'] == 'admin'){
//                     return AdminHomePage();
//                   }else{
//                     return HomePage();
//                   }
//                 }
//                 return Material(child: Center(child: CircularProgressIndicator(),),);
//               },
//             );
//           }
//           return MyLoginPage();
//         }
//     );
//   }
// }
import 'package:butom_navbar/admin/admin_or_user.dart';
import 'package:butom_navbar/admin/home.dart';
import 'package:butom_navbar/loginpage/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MainScreen(),
      home: MyLoginPage(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(snapshot.data.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData && snapshot.data != null){
                  final user = snapshot.data.data();
                  if(user['role'] == 'admin'){
                    return AdminHomePage();
                  }else{
                    return HomePage();
                  }
                }
                return Material(child: Center(child: CircularProgressIndicator(),),);
              },
            );
          }
          return MyLoginPage();
        }
    );
  }
}