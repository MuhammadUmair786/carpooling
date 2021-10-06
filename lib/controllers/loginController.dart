import 'package:carpooling_app/views/bottomnavbar.dart';
import 'package:carpooling_app/views/startingdetails.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class LoginController extends GetxController {
  var isOTPScreen = false.obs;
  var timer = 60.obs;
  late String phoneNo;
  late String smsCode;
  FirebaseAuth auth = FirebaseAuth.instance;

  void startTimmer() {
    Timer.periodic(Duration(seconds: 1), (_) {
      timer.value--;
    });
  }

  sendCodeToAutoVerifyPhone(String phone) async {
    showLoading();
    phoneNo = "+92" + phone;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential).then((value) {
            isOTPScreen.value = false;
            timer.value = 0;
            update();
            decidesNextScreen();

            Get.snackbar(
              "default title",
              "default Message",
              titleText: Text(
                "OTP Fetched automatically",
                textScaleFactor: 1.5,
              ),
              messageText: Text(
                "You are sucessfully Login",
                textScaleFactor: 1.3,
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.black,
              colorText: Colors.black,
              backgroundGradient: LinearGradient(
                colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
              ),
            );
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          // Get.defaultDialog()
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          } else {
            print(e.toString());
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          smsCode = verificationId;
          dismissLoadingWidget();
          isOTPScreen(true);
          update();
          startTimmer();

          Get.snackbar(
            "default title",
            "default Message",
            titleText: Text(
              "OTP Sent",
              textScaleFactor: 1.5,
            ),
            messageText: Text(
              "Please check your phone for the verification code",
              textScaleFactor: 1.3,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.black,
            backgroundGradient: LinearGradient(
              colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          smsCode = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (error) {
      print("sendCodeToAutoVerifyPhone");
      print(error);
      Get.snackbar(
        "default title",
        "default Message",
        titleText: Text(
          "Oop's",
          textScaleFactor: 1.5,
        ),
        messageText: Text(
          "Something's went wrong",
          textScaleFactor: 1.3,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
    }
  }

  Future<void> signInWithPhoneNumber(String userEnteredOTP) async {
    showLoading();

    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: smsCode, //sent by Firebase
        smsCode: userEnteredOTP, //enter by user
      );

      await auth.signInWithCredential(credential).then((value) {
        isOTPScreen.value = false;
        timer.value = 0;
        update();
        decidesNextScreen();

        Get.snackbar(
          "default title",
          "defalt message",
          titleText: Text(
            "Welcome To Carpooling App",
            textScaleFactor: 1.4,
          ),
          messageText: Text(
            "You are sucessfully Login",
            textScaleFactor: 1.3,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.black,
          backgroundGradient: LinearGradient(
            colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
          ),
        );
      });
    } catch (e) {
      print("signInWithPhoneNumber");
      print(e);
      Get.snackbar(
        "default title",
        "", //default message
        titleText: Text(
          "Failed to sign in",
          textScaleFactor: 1.5,
        ),
        messageText: null,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
    }
  }

  decidesNextScreen() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid) //create document with user id
        .get()
        .then((value) {
      if (value.exists) {
        print(value.toString());
        Get.offAll(() => BottomNavBar());
      } else {
        Get.offAll(() => StartingDetails());
      }
    });
  }

  Future<void> createUserDocument(String name, DateTime dob) async {
    showLoading();

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set({
      // 'map1': {
      //   'key1': 'value1',
      //   'key2': 'value2',
      // }
      "name": name,
      "dob": dob.microsecondsSinceEpoch,
    }).then((value) {
      print("User initial Details Added");
      Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add user initial Details: $error");
      dismissLoadingWidget();
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "Oops!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "Something wents wrong, Try Again",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
    });

    // FirebaseFirestore.instance.collection("users").doc(userid).update(data)
  }
}
