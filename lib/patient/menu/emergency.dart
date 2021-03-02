import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Welcome\nHospital'
              ),
            ),
            ListTile(
              title: Text('Emergency'),
              onTap: (){
              },
            )
          ],
        ),
      ),
    );
  }
}
