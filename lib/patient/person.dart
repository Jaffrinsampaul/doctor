import 'package:butom_navbar/buttom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:form_field_validator/form_field_validator.dart';

class Person extends StatefulWidget {
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {

  TextEditingController sampledata1 = new TextEditingController();
  TextEditingController sampledata2 = new TextEditingController();
  TextEditingController sampledata3 = new TextEditingController();
  TextEditingController sampledata4 = new TextEditingController();
  TextEditingController sampledata5 = new TextEditingController();
  TextEditingController sampledata6 = new TextEditingController();


  List<String> _gender = ["Male", "Female"];
  String _selectedGender;

  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            // key: _formKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add patient',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Patient Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: sampledata1,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  hintText: "Enter your name",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Patient Contact No",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: sampledata2,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  hintText: "Enter your Contact No",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Patient Email",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: sampledata3,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  hintText: "Enter Email Id",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Gender",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    isExpanded: true,
                      hint: Text('Select Gender'),
                      value: _selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      items: _gender.map((gender) {
                        return DropdownMenuItem(
                          child: new Text(gender),
                          value: gender,
                        );
                      }).toList()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Patient Address",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: sampledata4,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  hintText: "Enter Patient Address",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.streetAddress,
                minLines: 3,
                maxLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Patient Age",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: sampledata5,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  hintText: "Enter Patient Age",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Medical History",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: sampledata6,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  hintText: "Enter Patient Medical History (if any)",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                minLines: 2,
                maxLines: 6,
              ),
              SizedBox(
                height: 15,
              ),
              OutlineButton(
                  focusColor: Color(0xffC0C0E4),
                  child: Text(
                    'Add',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "field1": sampledata1.text,
                      "field2": sampledata2.text,
                      "field3": sampledata3.text,
                      "field4": sampledata4.text,
                      "field5": sampledata5.text,
                      "field6": sampledata6.text,
                      "GENDER" : _selectedGender,
                      // "Created Date" : user.metadata.creationTime.toString(),
                    };
                    FirebaseFirestore.instance.collection("Patient detail").add(data);
                  }), //
            ],
          ),
        ),
      ),
    ));
  }
}
