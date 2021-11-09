// import 'dart:async';

import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/models/rideModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserModel {
  late String name = 'null';
  late DateTime dob;
  late String homeAddress = "null";
  Map<String, dynamic> nomineeDetails = {};
  Map<String, dynamic> cnicDetails = {};
  Map<String, dynamic> workingDetails = {};
  List<dynamic> vehicleList = [];
  List<dynamic> postedRidesList = [];
  // late String id;
  // late String id;

  UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot}) {
    // id = documentSnapshot.id;
    name = snapshot["name"];
    if (snapshot.data()!.containsKey('nominee')) {
      nomineeDetails = snapshot['nominee'];
    }
    if (snapshot.data()!.containsKey('vehicles')) {
      vehicleList = snapshot['vehicles'];
      // print(vehicleList[0]);
    }
    loadRides();
    // email = documentSnapshot["email"];
  }

  loadRides() {
// .collection("ride")
// .where("id", "==", "5eWDvE6dZ1R1ubVG0SvE")
    // var querySnapshots =
    FirebaseFirestore.instance
        .collection('ride')
        .where("driverID", isEqualTo: Get.find<AuthController>().userfb!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        // print(element['endAddress']);
        postedRidesList.add(RideModel.fromDocumentSnapshot(snapshot: element));
      });
    });

    // print(postedRides);
  }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
