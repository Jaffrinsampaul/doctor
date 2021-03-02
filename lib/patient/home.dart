import 'package:butom_navbar/patient/appointment.dart';
import 'package:butom_navbar/patient/daily_practices.dart';
import 'package:butom_navbar/patient/first_aid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home1 extends StatefulWidget {
  @override
  _HomeState1 createState() => _HomeState1();
}

class _HomeState1 extends State<Home1> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Welcome to Virtual Hosptial",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Appointment_user(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            height: MediaQuery.of(context).size.height * 0.33,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              image: DecorationImage(
                                image: AssetImage("assest/img2.jpg"),
                                  fit: BoxFit.contain
                              ),
                            ),
                          ),
                          Text(
                            "Appointment",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => First_Aid(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.33,
                            width: MediaQuery.of(context).size.width * 0.33,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assest/img1.jpg"),
                                    fit: BoxFit.contain)),
                          ),
                          Text(
                            "First Acid",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height*0.1,
              // ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Appointment_user(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.33,
                            width: MediaQuery.of(context).size.width * 0.33,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              image: DecorationImage(
                                image: AssetImage("assest/img2.jpg"),
                                  fit: BoxFit.contain
                              ),
                            ),
                          ),
                          Text(
                            "data",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Daily_Practices(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.33,
                            width: MediaQuery.of(context).size.width * 0.33,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assest/img1.jpg"),
                                    fit: BoxFit.contain)),
                          ),
                          Text(
                            "Daily Practices",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Top_Doc extends StatefulWidget {
  @override
  _Top_DocState createState() => _Top_DocState();
}

class _Top_DocState extends State<Top_Doc> {
  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("Doctor_Detail").getDocuments();

    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: getPost(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading...."),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].data["name"]),
                      );
                    });
              }
            }),
      ),
    );
  }
}
