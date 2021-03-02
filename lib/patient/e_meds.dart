import 'package:flutter/material.dart';

class person_Medic extends StatefulWidget {
  @override
  _person_MedicState createState() => _person_MedicState();
}

class _person_MedicState extends State<person_Medic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Person E-meds'
        ),
      ),
    );
  }
}
