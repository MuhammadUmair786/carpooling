// import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideModel {
  // late String driverId;
  // late DateTime date;
  // late String homeAddress = "null";
  // Map<String, dynamic> nomineeDetails = {};
  // Map<String, dynamic> cnicDetails = {};
  // Map<String, dynamic> workingDetails = {};
  // List<dynamic> vehicleList = [];
  // List<dynamic> postedRidesList = [];
  // late String id;
  // late String id;
  late String startingAddress;
  late LatLng startingPoints;
  late String endAddress;
  late LatLng endPoints;
  late String route;
  //ads route points or poluline later on
  late DateTime date;
  late TimeOfDay time;
  late String gender;
  late String vehicleId;
  late double vehicleMilage;
  late bool isAc;
  late String message;
  late bool? isSavedTemplate;

  RideModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot}) {
    // id = documentSnapshot.id;
    // name = snapshot["name"];
    // if (snapshot.data()!.containsKey('nominee')) {
    //   nomineeDetails = snapshot['nominee'];
    // }
    // if (snapshot.data()!.containsKey('vehicles')) {
    //   vehicleList = snapshot['vehicles'];
    //   // print(vehicleList[0]);
    // }
    // email = documentSnapshot["email"];
  }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
