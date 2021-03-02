import 'package:flutter/material.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Bmi_Calculator(),
    );
  }
}

class Bmi_Calculator extends StatefulWidget {
  @override
  _Bmi_CalculatorState createState() => _Bmi_CalculatorState();
}

class _Bmi_CalculatorState extends State<Bmi_Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Center(
        child: Text('Body Text'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}