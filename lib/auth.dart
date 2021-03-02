import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info/package_info.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;

  Stream<User> authStateChanges();

  Future<User> signInAnonymously();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password);

  // Future<User> signInWithGoogle();

  // Future<User> signInWithFacebook();

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return userCredential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User user = userCredential.user;
    // return userCredential.user;
    return user;
  }

  @override
  // Future<User> signInWithGoogle() async {
  //   final googleSignIn = GoogleSignIn();
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser != null) {
  //     final googleAuth = await googleUser.authentication;
  //     if (googleAuth.idToken != null) {
  //       final userCredential = await _firebaseAuth
  //           .signInWithCredential(GoogleAuthProvider.credential(
  //         idToken: googleAuth.idToken,
  //         accessToken: googleAuth.accessToken,
  //       ));
  //       return userCredential.user;
  //     } else {
  //       throw FirebaseAuthException(
  //         code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
  //         message: 'Missing Google ID Token',
  //       );
  //     }
  //   } else {
  //     throw FirebaseAuthException(
  //       code: 'ERROR_ABORTED_BY_USER',
  //       message: 'Sign in aborted by user',
  //     );
  //   }
  // }

  @override
  // Future<User> signInWithFacebook() async {
  //   final fb = FacebookLogin();
  //   final response = await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);
  //   switch (response.status) {
  //     case FacebookLoginStatus.Success:
  //       final accessToken = response.accessToken;
  //       final userCredential = await _firebaseAuth.signInWithCredential(
  //         FacebookAuthProvider.credential(accessToken.token),
  //       );
  //       return userCredential.user;
  //     case FacebookLoginStatus.Cancel:
  //       throw FirebaseAuthException(
  //         code: 'ERROR_ABORTED_BY_USER',
  //         message: 'Sign in aborted by user',
  //       );
  //     case FacebookLoginStatus.Error:
  //       throw FirebaseAuthException(
  //         code: 'ERROR_FACEBOOK_LOGIN_FAILED',
  //         message: response.error.developerMessage,
  //       );
  //     default:
  //       throw UnimplementedError();
  //   }
  // }
  @override
  Future<void> signOut() async {
    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
    // final facebookLogin = FacebookLogin();
    // await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveUser(User user) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime,
      "created_at": user.metadata.creationTime ,
      "role": "user",
      "build_Number": buildNumber,
    };

    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "build_Number": buildNumber,
      });
    } else {
      await userRef.set(userData);
    }
    await _saveDevice(user);
  }

  static _saveDevice(User user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    Map<String, dynamic> deviceData;
    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = {
        "os_version": deviceInfo.version.sdkInt.toString(),
        "Platform": "Android",
        "model": deviceInfo.model,
        "device": deviceInfo.device,
      };
    }
    if (Platform.isIOS) {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        "os_version": deviceInfo.systemVersion,
        "Platform": "IOS",
        "model": deviceInfo.model,
        "device": deviceInfo.name,
      };
    }
    final nowMS = DateTime.now().millisecondsSinceEpoch;
    final deviceRef = _db
        .collection("users")
        .doc(user.uid)
        .collection("devices")
        .doc(deviceId);
    if((await deviceRef.get()).exists){
      await deviceRef.update({
        "updated_at" : nowMS,
        "uninstalled": false,
      });
    }else{
      deviceRef.set({
        "created_at" : nowMS,
        "updated_at" : nowMS,
        "uninstalled" : false,
        "id" : deviceId,
        "device_info" : deviceData,
      });
    }
  }
}
