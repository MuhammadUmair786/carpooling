// import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String id;
  late String name;
  String? img;
  late DateTime dob;
  late String homeAddress = "null";
  double rating = 0.0; //get from database
  double profileComplete = 30; //get from database
  Map<String, dynamic> nomineeDetails = {};
  Map<String, dynamic> cnicDetails = {};
  Map<String, dynamic> workingDetails = {};
  List<dynamic> vehicleList = [];
  // List<RideModel> postedRidesList = [];
  List<dynamic> chatList = [];
  // late String id;
  // late String id;

  UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot,
      bool isLoadOthers = true}) {
    id = snapshot.data()!["id"];
    name = snapshot.data()!["name"];
    img = snapshot.data()!["profileImg_ur"];
    // img = null;
    //if other data is not requrired
    if (isLoadOthers) {
      if (snapshot.data()!.containsKey('nominee')) {
        nomineeDetails = snapshot.data()!['nominee'];
      }
      if (snapshot.data()!.containsKey('vehicles')) {
        vehicleList = snapshot.data()!['vehicles'];
        // print(vehicleList[0]);
      }
      if (snapshot.data()!.containsKey('chatList')) {
        chatList = snapshot.data()!['chatList'];
        // print(vehicleList[0]);
      }
      // loadRides();
    }
    // email = documentSnapshot["email"];
  }

  // loadRides() {
  //   // postedRidesList.clear();
  //   FirebaseFirestore.instance
  //       .collection('ride')
  //       .where("driverID", isEqualTo: Get.find<AuthController>().userfb!.uid)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       // postedRidesList.add(RideModel.fromDocumentSnapshot(snapshot: element));
  //     });
  //   });
  // }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
