import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name;
  late DateTime dob;
  late String homeAddress;
  late Map<String, String> nomineeDetails;
  // late Map<String, String> cnicDetails;
  // late Map<String, String> workingDetails;
  late String id;
  // late String id;

  UserModel({required this.id, required this.name});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    // email = documentSnapshot["email"];
  }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
