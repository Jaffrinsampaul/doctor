// import 'package:butom_navbar/nav_button/e_meds.dart';
// import 'package:butom_navbar/nav_button/history.dart';
// import 'package:butom_navbar/nav_button/person.dart';
// import 'package:butom_navbar/nav_button/report.dart';
// import 'package:flutter/material.dart';
// import 'nav_button/admin_or_user.dart';
// import 'dart:io';
//
// class Navbar extends StatefulWidget {
//   @override
//   _NavbarState createState() => _NavbarState();
// }
//
// class _NavbarState extends State<Navbar> {
//   // List<IconData> _iconList = [];
//   // int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.bottomCenter,
//         // width: MediaQuery.of(context).size.width / _iconList.length,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//                 icon: Icon(Icons.home),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => Home1(),
//                   ));
//                 }),
//             IconButton(
//                 icon: Icon(Icons.person),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => Person(),
//                   ));
//                 }),
//             IconButton(
//                 icon: Icon(Icons.text_snippet),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => person_History(),
//                   ));
//                 }),
//             IconButton(
//                 icon: Icon(Icons.local_hospital_outlined),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => person_Report(),
//                   ));
//                 }),
//             IconButton(
//                 icon: Icon(Icons.medical_services_outlined),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => person_Medic(),
//                   ));
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:butom_navbar/auth.dart';
import 'package:butom_navbar/bmi_calculator/bmi_calculator.dart';
import 'package:butom_navbar/patient/e_meds.dart';
import 'package:butom_navbar/patient/history.dart';
import 'package:butom_navbar/patient/home.dart';
import 'package:butom_navbar/patient/menu/emergency.dart';
import 'package:butom_navbar/patient/menu/main_drawer.dart';
import 'package:butom_navbar/patient/person.dart';
import 'package:butom_navbar/patient/report.dart';
import 'package:butom_navbar/search.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {

  // MyNavigationBar ({Key key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  Auth auth = new Auth();

  Future<void> _signOut(){
    try{
      auth.signOut();
    }
    catch(e){
    }
  }
  List<String> _locations = [
    'Chennai',
    'Madurai',
    'Tirunelveli',
    'Thoothukudi'
  ]; // Option 2
  String _selectedLocation;

  int _currentIndex = 0;
  final tabs = [
    Home1(),
    Person(),
    person_History(),
    person_Report(),
    person_Medic(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(40,0,5,0),
                  child: DropdownButton(
                    hint: Text(
                        'Please choose a location'), // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Search(),
                      ));
                    }),
                IconButton(
                    icon: Icon(Icons.calculate),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Bmi_Calculator(),));
                    }),
                IconButton(
                    icon: Icon(Icons.logout),
                    color: Colors.grey,
                    onPressed: () {
                      _signOut();
                    }),
              ],
            ),
          ),
        ],
      ),
      drawer: Main_Drawer(),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Detail'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.text_snippet,
            ),
            title: Text('History'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            title: Text('Report'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            title: Text('E-medic'),
            // backgroundColor: Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
