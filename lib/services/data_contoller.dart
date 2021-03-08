import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firestoreFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestoreFirestore.collection(collection).get();
    return snapshot.docs;
  }
  Future queryData(String queryString) async {
    return FirebaseFirestore.instance.collection("users").where('email',isGreaterThanOrEqualTo: queryString).get();
  }



}