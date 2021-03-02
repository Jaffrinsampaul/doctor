import 'package:butom_navbar/auth_helper.dart';
import 'package:butom_navbar/onboarding/onboarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:butom_navbar/auth.dart';
import 'signin.dart';

abstract class AuthBase {
  User get currentUser;

  Future<User> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

}

class Create_account extends StatefulWidget {
  @override
  _Create_accountState createState() => _Create_accountState();
}

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  filled: true,
  fillColor: Colors.white30,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide.none,
  ),
);

class _Create_accountState extends State<Create_account>
    {
  String email;
  String password;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
  }

  Auth auth = new Auth();
  User user;

  Future<User> _createUserWithEmailAndPassword (String email, String password) async {
    // Auth auth = new Auth();
    try {
       await auth.createUserWithEmailAndPassword(email, password);
      user = auth.currentUser;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bglogin.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          // 'You are,\nUp Above The Sky!',
                          'Signup Here',
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 60, right: 130),
                      child: Text(
                        'Get Started Here!',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: TextField(
                          // onChanged: (value) {
                          //   email = value;
                          // },
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          style: TextStyle(color: Colors.white, fontSize: 23),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter email',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: TextField(
                          // onChanged: (value) {
                          //   password = value;
                          // },
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: Colors.white, fontSize: 23),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: TextField(
                          // onChanged: (value) {
                          //   password = value;
                          // },
                          obscureText: true,
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: Colors.white, fontSize: 23),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Confirm Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          _createUserWithEmailAndPassword(
                              email, password);
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            print("Email and password cannot be empty");
                            return;
                          }
                          if (_confirmPasswordController.text.isEmpty ||
                              _passwordController.text !=
                                  _confirmPasswordController.text) {
                            print("confirm password does not match");
                            return;
                          }
                          try {
                            final user = await AuthHelper.signupWithEmail(
                                email: _emailController.text,
                                password: _passwordController.text);
                            if (user != null) {
                              Navigator
                                  .push(context,MaterialPageRoute(
                                builder: (context) => Home(),
                              ));
                            }
                          }
                          catch (e) {
                            print(e);
                          }
                          // }else {
                          //   showDialog(
                          //     builder: (context) => Padding(
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 40, vertical: 250),
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(40)),
                          //         ),
                          //         child: Column(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.center,
                          //           children: [
                          //             Lottie.asset(
                          //                 'images/32887-success.json',
                          //                 height: 150),
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Material(
                          //                 child: Text('Already used'),
                          //                 color: Colors.white,
                          //                 type: MaterialType.card,
                          //                 textStyle: TextStyle(
                          //                     fontSize: 25,
                          //                     color: Colors.black),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     context: context,
                          //   );
                          // }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        child: Container(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'Already do you have account',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ),
                        onTap: () {
                          try {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyLoginPage()),
                            );
                          } catch (e) {}
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
