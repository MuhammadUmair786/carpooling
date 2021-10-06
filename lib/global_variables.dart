import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalVariables {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');
}
