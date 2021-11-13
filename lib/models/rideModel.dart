// import 'dart:async';
import 'package:carpooling_app/models/requestRideModel.dart';
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
  late String id;
  late String startingAddress;
  late LatLng startPoint;
  late String endAddress;
  late LatLng endPoint;
  late String route;
  //ads route points or poluline later on
  late DateTime startDate;
  late TimeOfDay time;
  late String gender;
  late String vehicleId;
  late double vehicleMilage;

  late String vehicleImg;
  late bool isAc;
  late String message;
  late bool? isSavedTemplate;
  late DateTime postedDate;
  List<RequestModel> requestList = [];

  RideModel.fromDocumentSnapshot(
      {required QueryDocumentSnapshot<Map<String, dynamic>> snapshot}) {
    id = snapshot['id'];
    startingAddress = snapshot['startAddress'];
    GeoPoint start = snapshot['startPoint'];
    startPoint = LatLng(start.latitude, start.longitude);
    endAddress = snapshot['endAddress'];
    GeoPoint end = snapshot['endPoint'];
    endPoint = LatLng(end.latitude, end.longitude);
    route = snapshot['route'];
    startDate = DateTime.fromMicrosecondsSinceEpoch(snapshot['date']);
    time = TimeOfDay(
        hour: snapshot['time']['hour'], minute: snapshot['time']['minute']);
    gender = snapshot['gender'];
    vehicleId = snapshot['vehicle']['id'];
    vehicleImg = snapshot['vehicle']['img_url'];
    vehicleMilage = snapshot['vehicle']['milage'];
    isAc = snapshot['vehicle']['isAC'];
    message = snapshot['message'];
    isSavedTemplate = snapshot['isSaved'];
    postedDate = DateTime.fromMicrosecondsSinceEpoch(snapshot['postedAt']);

    if (snapshot.data().containsKey('request')) {
      // vehicleList = snapshot['vehicles'];
      // print(vehicleList[0]);
      var tempList = snapshot['request'];

      for (var item in tempList) {
        requestList
            .add(RequestModel.fromDocumentSnapshot(snapshot: item, rideId: id));
      }
    }
  }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
