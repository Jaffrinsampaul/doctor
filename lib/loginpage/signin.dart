// import 'package:animated_loginpage_app/HomeScreen.dart';
import 'package:butom_navbar/auth_helper.dart';
import 'package:butom_navbar/onboarding/onboarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:butom_navbar/loginpage/newaccount.dart';

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
      debugShowCheckedModeBanner: false,
      home: MyLoginPage(),
    );
  }
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

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  // String email;
  // String password;
  //
  // Auth auth = new Auth();
  // User user;
  //
  // Future<void> _signInWithEmailandPassword(String email, String password) {
  //   // Auth auth = new Auth();
  //   try {
  //     auth.signInWithEmailAndPassword(email, password);
  //     user = auth.currentUser;
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/loginbg.jpg'),
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
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Welcome to \nVirtual Hospital!',
                          textAlign: TextAlign.left,
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
                        'Login Here',
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
                            hintText: 'Enter your E-mail id',
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
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          style: TextStyle(color: Colors.white, fontSize: 23),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25))),
                          child: Container(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              print("Email and password cannot be empty");
                              return;
                            }
                            try {
                              final user = await AuthHelper.signInWithEmail(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              if (user != null) {
                                // print("Login Successful");
                                Navigator
                                    .push(context,MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                              }
                            } catch (e) {
                              print(e);
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      //
                      GestureDetector(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Don\'t have an account? Sign Up',
                            // textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          try {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Create_account()),
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
