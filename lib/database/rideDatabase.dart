// import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/controllers/bottomNavBarController.dart';
import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/models/requestRideModel.dart';
import 'package:carpooling_app/models/rideModel.dart';
import 'package:carpooling_app/views/bottomnavbar.dart';
import 'package:carpooling_app/views/chating/chatRoom.dart';
import 'package:carpooling_app/views/drawer/savedTemplate.dart';
import 'package:carpooling_app/views/rides/rideScreen.dart';
import 'package:carpooling_app/widgets/generateRoomId.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideDatabase {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static var rideCollection = FirebaseFirestore.instance.collection('ride');
  // static var rideRequestCollection = rideCollection.doc(rideID).collection("request")

  static var rideRequestCollection =
      FirebaseFirestore.instance.collection('request');
  // static CollectionReference getCollectionRef(String rideID) {
  //   return rideCollection.doc(rideID).collection("request");
  // }

  static Future<void> postNewRide({
    required String startingAddress,
    required LatLng startingPoints,
    required String startPostalCode,
    required String startCity,
    required String startSubLocality,
    required String endAddress,
    required LatLng endPoints,
    required String endPostalCode,
    required String endCity,
    required String endSubLocality,
    required String route,
    //ads route points or poluline later on
    required DateTime date,
    required TimeOfDay time,
    required String gender, //
    required String vehicleId,
    required double vehicleMilage,
    required String vehicleImg,
    required bool isAc,
    required String vehicleType, //
    required String message,
    required int totalSeats,
    required bool isSavedTemplate,
  }) async {
    showLoading();

    // startingPoints.

    //upload cnic and img_url to user info
    rideCollection.add({
      "driverID": auth.currentUser!.uid,
      "startAddress": startingAddress,
      "startPostalCode": startPostalCode,
      "startSubLocality": startSubLocality,
      "startCity": startCity,
      "startPoint": GeoPoint(startingPoints.latitude, startingPoints.longitude),
      "endAddress": endAddress,
      "endPostalCode": endPostalCode,
      "endSubLocality": endSubLocality,
      "endCity": endCity,
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
        "type": vehicleType,
        "milage": vehicleMilage,
        "img_url": vehicleImg,
        "isAC": isAc,
      },
      "message": message,
      "isSaved": isSavedTemplate,
      "postedAt": DateTime.now().microsecondsSinceEpoch,
      "confirmedSeats": 0,
      "totalSeats": totalSeats
    }).then((value) {
      // print(value.id);

      rideCollection.doc(value.id).update({"id": value.id}).then((value) {
        dismissLoadingWidget();
        Get.offAll(() => BottomNavBar());
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
    required String driverID,
    required String passangerID,
    required String startAddress,
    required LatLng startPoint,
    required String endAddress,
    required LatLng endPoint,
    required String message,
    required int seats,
  }) async {
    // showLoading();

    rideRequestCollection.add({
      "passangerID": passangerID,
      "rideID": rideID,
      "driverID": driverID,
      "startPoint": GeoPoint(startPoint.latitude, startPoint.longitude),
      "startAddress": startAddress,
      "endPoint": GeoPoint(endPoint.latitude, endPoint.longitude),
      "endAddress": endAddress,
      "message": message,
      "seats": seats,
      "isConfirmed": false,
      "requestedAt": DateTime.now().microsecondsSinceEpoch,
    }).then((value) {
      // print(value.id);

      rideRequestCollection
          .doc(value.id)
          .update({"requestId": value.id}).then((value) {
        Get.back();

        showSnackBar("Request Sent Sucessfuly!", "");

        // Get.to(() => RideScreen(currentTab: 1));
      }).catchError((error) {
        print("Failed to Sent Request: $error");
        showErrorSnackBar(
            title: "Failed to Post Ride' ", message: "Please Try again!");
      });
    }).catchError((error) {
      print("Failed to Post Ride Request: $error");
      showErrorSnackBar(
          title: "Failed to Post Ride Request", message: "Please Try again!");
    });
  }

  static List<RequestModel> loadRideRequests(String rideId) {
    List<RequestModel> tempRequestList = [];

    rideRequestCollection
        .where("rideID", isEqualTo: rideId)
        .get()
        .then((querySnapshot) {
      for (var request in querySnapshot.docs) {
        tempRequestList
            .add(RequestModel.fromDocumentSnapshot(snapshot: request.data()));
      }
    });
    return tempRequestList;
  }

  static rejectRideRequests(String requestID) {
    rideRequestCollection.doc(requestID).delete().then((value) {
      showSnackBar("Request will remove soon", "");
    });
  }

  static acceptRideRequests(
      String requestID, String rideID, int previousSeatsValue) {
    print(requestID);
    rideRequestCollection
        .doc(requestID)
        .update({"isConfirmed": true}).then((value) {
      rideCollection
          .doc(rideID)
          .update({"confirmedSeats": (previousSeatsValue + 1)}).then((value) {
        showSnackBar("Ride Request Accepted", "");
      });
    });
  }

  ///here other user means the user to whome driver want to talk
  ///it returns roomID after creating chat instances in database
  static String manageChatAndReturnRoomID(
      String otherUserID, String otherUserName) {
    var roomID = chatRoomId(auth.currentUser!.uid.toString().substring(0, 10),
        otherUserID.substring(0, 10));

    UserDatabase.addChatList(otherUserData: {
      "roomID": roomID,
      "name": otherUserName,
      "id": otherUserID
    });

    return roomID;
  }

  static RideModel? getRideModel(String rideID) {
    FirebaseFirestore.instance
        .collection('ride')
        .doc(rideID)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return RideModel.fromDocumentSnapshot(snapshot: documentSnapshot);
      } else {
        print("User document not found");
        return null;
      }
    });
  }

  static deleteRide(String rideID) {
    rideCollection.doc(rideID).delete().then((value) {
      showSnackBar("Request will remove soon", "");
    });
  }
}
