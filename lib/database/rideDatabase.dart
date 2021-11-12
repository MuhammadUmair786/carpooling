// import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/views/drawer/savedTemplate.dart';
import 'package:carpooling_app/views/rides/rideScreen.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideDatabase {
  static var rideCollection = FirebaseFirestore.instance.collection('ride');

  static Future<void> postNewRide({
    required String startingAddress,
    required LatLng startingPoints,
    required String endAddress,
    required LatLng endPoints,
    required String route,
    //ads route points or poluline later on
    required DateTime date,
    required TimeOfDay time,
    required String gender,
    required String vehicleId,
    required double vehicleMilage,
    required String vehicleImg,
    required bool isAc,
    required String message,
    bool? isSavedTemplate,
  }) async {
    showLoading();

    // startingPoints.

    //upload cnic and img_url to user info
    rideCollection.add({
      "driverID": Get.find<AuthController>().userfb!.uid,
      "startAddress": startingAddress,
      "startPoint": GeoPoint(startingPoints.latitude, startingPoints.longitude),
      "endAddress": endAddress,
      "endPoint": GeoPoint(endPoints.latitude, endPoints.longitude),
      "route": route,
      "date": date.microsecondsSinceEpoch,
      "time": {
        "hour": time.hour,
        "minute": time.minute,
      },
      "gender": gender,
      "vehicle": {
        "id": vehicleId,
        "milage": vehicleMilage,
        "img_url": vehicleImg,
        "isAC": isAc,
      },
      "message": message,
      "isSaved": isSavedTemplate,
      "postedAt": DateTime.now().microsecondsSinceEpoch,
    }).then((value) {
      // print(value.id);

      rideCollection.doc(value.id).update({"id": value.id}).then((value) {
        dismissLoadingWidget();
        Get.to(() => RideScreen());
        showSnackBar("Ride Post Sucessfuly!", "");
      }).catchError((error) {
        print("Failed to Post Ride ID: $error");
        dismissLoadingWidget();
        showErrorSnackBar(
            title: "Failed to Post Ride' ", message: "Please Try again!");
      });
    }).catchError((error) {
      print("Failed to Post Ride: $error");
      dismissLoadingWidget();
      showErrorSnackBar(
          title: "Failed to Post Ride", message: "Please Try again!");
    });
  }

  static Future<void> removeFromTemplate({
    required String documentID,
  }) async {
    // showLoading();

    // startingPoints.

    //upload cnic and img_url to user info
    rideCollection.doc(documentID).update({"isSaved": false}).then((value) {
      // dismissLoadingWidget();
      Get.to(() => SavedTemplate());
      showSnackBar("Ride Remove Sucessfuly!", "");
    }).catchError((error) {
      // print("Failed to Post Ride: $error");
      // dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static Future<void> sendRequestToJoin({
    required String rideID,
    required String passangerID,
    required LatLng startPoint,
    required LatLng endPoint,
    required String message,
    required int seats,
  }) async {
    // showLoading();
    // showLoading();
    var _tempRequestList = [
      {
        "passangerID": passangerID,
        "startPoint": GeoPoint(startPoint.latitude, startPoint.longitude),
        "endPoint": GeoPoint(endPoint.latitude, endPoint.longitude),
        "message": message,
        "seats": seats,
        "isConfirmed": false,
        "requestedAt": DateTime.now().microsecondsSinceEpoch,
      }
    ];
    rideCollection.doc(rideID).update(
        {'request': FieldValue.arrayUnion(_tempRequestList)}).then((value) {
      // print("Nominee Details Added");
      // dismissLoadingWidget();
      showSnackBar("Request Sent Sucessfuly!", "");
    }).catchError((error) {
      print("Failed to add user initial Details: $error");
      // dismissLoadingWidget();
      showErrorSnackBar();
    });
  }
}
