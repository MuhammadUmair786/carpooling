// import 'dart:async';
import 'package:carpooling_app/database/rideDatabase.dart';
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
  late String driverId;
  late String startingAddress;
  late LatLng startPoint;

  late String startPostalCode;
  late String startCity;
  late String startSubLocality;

  late String endAddress;
  late LatLng endPoint;

  late String endPostalCode;
  late String endCity;
  late String endSubLocality;

  late String route;
  //ads route points or poluline later on
  late DateTime startDate;
  late TimeOfDay time;
  late String gender;
  late String vehicleId;
  late double vehicleMilage;

  late String vehicleImg;

  late String vehicleType;
  late bool isAc;
  late String message;
  late bool? isSavedTemplate;
  late DateTime postedDate;
  late int totalSeats;
  late int confirmedSeats;
  // List<RequestModel> requestList = [];

  RideModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot}) {
    id = snapshot['id'];
    driverId = snapshot['driverID'];
    startingAddress = snapshot['startAddress'];
    GeoPoint start = snapshot['startPoint'];
    startPoint = LatLng(start.latitude, start.longitude);
    startCity = snapshot['startCity'];
    startPostalCode = snapshot['startPostalCode'];
    startSubLocality = snapshot['startSubLocality'];
    endAddress = snapshot['endAddress'];
    GeoPoint end = snapshot['endPoint'];
    endPoint = LatLng(end.latitude, end.longitude);
    endCity = snapshot['endCity'];
    endPostalCode = snapshot['endPostalCode'];
    endSubLocality = snapshot['endSubLocality'];
    route = snapshot['route'];
    startDate = DateTime.fromMicrosecondsSinceEpoch(snapshot['date']);
    time = TimeOfDay(
        hour: snapshot['time']['hour'], minute: snapshot['time']['minute']);
    gender = snapshot['gender'];
    vehicleId = snapshot['vehicle']['id'];
    totalSeats = snapshot['totalSeats'];
    confirmedSeats = snapshot['confirmedSeats'];
    vehicleType = snapshot['vehicle']['type'];
    vehicleImg = snapshot['vehicle']['img_url'];
    vehicleMilage = snapshot['vehicle']['milage'];
    isAc = snapshot['vehicle']['isAC'];
    message = snapshot['message'];
    isSavedTemplate = snapshot['isSaved'];
    postedDate = DateTime.fromMicrosecondsSinceEpoch(snapshot['postedAt']);

    // requestList = RideDatabase.loadRideRequests(id);
//manage ride requests from here

    // if (snapshot.data().containsKey('request')) {
    //   // vehicleList = snapshot['vehicles'];
    //   // print(vehicleList[0]);
    //   var tempList = snapshot['request'];

    //   for (var item in tempList) {
    //     requestList
    //         .add(RequestModel.fromDocumentSnapshot(snapshot: item, rideId: id));
    //   }
    // }
  }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
