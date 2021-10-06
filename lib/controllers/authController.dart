
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> _firebaseUser = Rx<User?>(null);

  var _googleUser = GoogleSignIn();
  var _googleAccount = Rx<GoogleSignInAccount?>(null);
  User? get user => _firebaseUser.value;

  @override
  onInit() {
    super.onInit();
    _firebaseUser.value = _auth.currentUser;
    _firebaseUser.bindStream(_auth.userChanges());
  }

  linkEmail() async {
    showLoading();
    _googleAccount.value = await _googleUser.signIn();
    GoogleSignInAuthentication googleAuth =
        await _googleAccount.value!.authentication;
    final googelCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    _auth.currentUser!.linkWithCredential(googelCredential).then((user) {
      _auth.userChanges();
      // // print(user.uid);
      // print("account merger");
      // print("\n\n\n\n PHOTO URL\n\n");
      // print(_googleAccount.value!.photoUrl);

      dismissLoadingWidget();
      Get.back();
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "Email Added Sucessfully",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
    }).catchError((error) {
      print(error.toString());
      dismissLoadingWidget();
      //if account not merge
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
  }
}
