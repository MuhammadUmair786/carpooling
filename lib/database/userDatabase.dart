import 'dart:io';

import 'package:carpooling_app/controllers/bottomNavBarController.dart';
import 'package:carpooling_app/models/userModel.dart';
import 'package:carpooling_app/views/bottomnavbar.dart';
import 'package:carpooling_app/views/settings/email_verification.dart';
import 'package:carpooling_app/views/vehicle/vehicle.dart';
import 'package:carpooling_app/widgets/costEstimation.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDatabase {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static var userDoc =
      FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid);

  static Future<void> createUserDocument(String name, DateTime dob) async {
    showLoading();

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set({
      "id": auth.currentUser!.uid.toString(),
      "name": name,
      "dob": dob.microsecondsSinceEpoch,
      "status": "online",
    }).then((value) {
      print("User initial Details Added");
      // Get.put(AuthController(), permanent: true);
      Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add user initial Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });

    // FirebaseFirestore.instance.collection("users").doc(userid).update(data)
  }

  static linkEmail() async {
    // _firebaseUser.
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      showLoading();
      var _googleAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth =
          await _googleAccount!.authentication;
      final googelCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      auth.currentUser!.linkWithCredential(googelCredential).then((user) {
        auth.userChanges();

        dismissLoadingWidget();
        Get.to(() => EmailVerificationScreen());
        showSnackBar("Email Added Sucessfully", "");
      }).catchError((error) {
        print(error.toString());
        dismissLoadingWidget();
        //if account not merge
        showErrorSnackBar();
      });
    } catch (ex) {
      dismissLoadingWidget();
      //if account not merge]
      showErrorSnackBar();
    }
  }

  static void addNomineeDetails(
      {required String name, required String relation, required String phone}) {
    showLoading();

    userDoc.update({
      'nominee': {
        "name": name,
        "relation": relation,
        "phone": phone,
      }
    }).then((value) {
      // print("Nominee Details Added");
      dismissLoadingWidget();
      showSnackBar("Details Added Sucessfuly!", "");
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add user nominee Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static Future<void> addCNIC(
      {required String cnic, required File image}) async {
    showLoading();
    FirebaseStorage storage = FirebaseStorage.instance;
    // upload image and get URL

    Reference reference = storage.ref().child("cnic/${auth.currentUser!.uid}");

    UploadTask uploadTask =
        reference.putFile(image); //Upload the file to firebase

    TaskSnapshot taskSnapshot = await uploadTask;

    // Waits till the file is uploaded then stores the download url
    String cnicUrl = await taskSnapshot.ref.getDownloadURL();

    //upload cnic and img_url to user info
    userDoc.update({
      'cnic': {
        "cnic": cnic,
        "cnic_url": cnicUrl,
      }
    }).then((value) {
      // print("Nominee Details Added");
      dismissLoadingWidget();
      showSnackBar("CNIC Details Added Sucessfuly!", "Wait for verification");
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add cnic Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static void addWorkingDetails({required Map<String, Object?> data}) {
    showLoading();
    userDoc.update({'workingDetails': data}).then((value) {
      // print("Nominee Details Added");
      dismissLoadingWidget();
      showSnackBar("Working Details Added Sucessfuly!", "");
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add working Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static Future<void> addLicense(
      {required String area,
      required String license,
      required String vehicle,
      required File image}) async {
    showLoading();
    FirebaseStorage storage = FirebaseStorage.instance;
    // upload image and get URL

    Reference reference =
        storage.ref().child("license/${auth.currentUser!.uid}");

    UploadTask uploadTask =
        reference.putFile(image); //Upload the file to firebase

    TaskSnapshot taskSnapshot = await uploadTask;

    // Waits till the file is uploaded then stores the download url
    String licenseUrl = await taskSnapshot.ref.getDownloadURL();

    //upload cnic and img_url to user info
    userDoc.update({
      'license': {
        "area": area,
        "license": license,
        "vehicle": vehicle,
        "license_url": licenseUrl,
      }
    }).then((value) {
      // print("Nominee Details Added");
      dismissLoadingWidget();
      showSnackBar(
          "License Details Added Sucessfuly!", "Wait for verification");

      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add license Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static Future<void> addVehicle(
      {required String vehicleType,
      required String company,
      required String model,
      required String year,
      required String color,
      String? engineType,
      required String engine,
      required String noAlp,
      required String noNum,
      required String milage,
      required File? image}) async {
    showLoading();
    FirebaseStorage storage = FirebaseStorage.instance;
    // upload image and get URL

    Reference reference =
        storage.ref().child("vehicle/${auth.currentUser!.uid}_$noNum");

    UploadTask uploadTask =
        reference.putFile(image!); //Upload the file to firebase

    TaskSnapshot taskSnapshot = await uploadTask;

    // Waits till the file is uploaded then stores the download url
    String imgUrl = await taskSnapshot.ref.getDownloadURL();

    // engineType = 1 non-hybrid
// engineType = 2 hybrid
// engineType = 3 Bike
    int sendingEngineType = 1;
    if (vehicleType == "Bike") {
      sendingEngineType = 3;
    } else if (engineType == "Hybrid") {
      sendingEngineType = 2;
    }
    double verifiedMilage = verifyMilage(
        int.parse(milage),
        sendingEngineType,
        int.parse(engine.toString().substring(0, (engine.length - 3))),
        int.parse(year));

    var _tempvehicileList = [
      {
        "id": auth.currentUser!.uid.toString().substring(18),
        "vehicleType": vehicleType,
        "company": company,
        "model": model,
        "year": year,
        "color": color,
        "engineType": engineType ?? "",
        "engine": engine,
        "noAlp": noAlp,
        "noNum": noNum,
        "milage": verifiedMilage,
        "img_url": imgUrl,
      }
    ];
    // print(_tempvehicileList.toString());

    userDoc.update({
      'vehicles': FieldValue.arrayUnion(_tempvehicileList),
    }).then((value) {
      dismissLoadingWidget();
      Get.to(() => Vehicle());
      showSnackBar("Vehicle Added Sucessfuly!", "Wait for verification");
    }).catchError((error) {
      print("Failed to add Vehicle Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static setStatus(String status) async {
    await userDoc.update({
      "status": status,
    });
  }

  ///update chat instance in otherUser and currentUser
  static void addChatList({required Map<String, Object?> otherUserData}) {
    var _tempChatList = [otherUserData];
    var otherUserDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(otherUserData["id"].toString());
    otherUserDoc.update(
        {'chatList': FieldValue.arrayUnion(_tempChatList)}).catchError((error) {
      print("Failed to add other user chat Details: $error");
    });
//currentUser
    var _currentTempChatList = [
      {
        "roomID": otherUserData['roomID'],
        "name": Get.find<BottomNavBarController>().getUser!.name,
        "id": Get.find<BottomNavBarController>().getUser!.id,
      }
    ];

    userDoc.update({
      'chatList': FieldValue.arrayUnion(_currentTempChatList)
    }).catchError((error) {
      print("Failed to add current user chat Details: $error");
    });
  }

  static UserModel? getUserModel(String userID) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return UserModel.fromDocumentSnapshot(snapshot: documentSnapshot);
      } else {
        print("User document not found");
        return null;
      }
    });
  }

  static void profileCompletion(double value) {
    userDoc
        .update({'profileComplete': value})
        .then((value) {})
        .catchError((error) {
          print("Failed to add user profileComplete value: $error");
          showErrorSnackBar();
        });
  }
}
