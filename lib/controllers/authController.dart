import 'package:carpooling_app/models/UserModel.dart';
import 'package:carpooling_app/views/settings/email_verification.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> _firebaseUser = Rx<User?>(null);

  Rx<UserModel?> _userData = Rx<UserModel?>(null);

  User? get userfb => _firebaseUser.value;
  UserModel? get userData => _userData.value;
  // UserModel

  @override
  onInit() {
    super.onInit();
    _firebaseUser.value = _auth.currentUser;
    _firebaseUser.bindStream(_auth.userChanges());

    // _userData.value = UserModel(id: userfb!.uid);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userfb!.uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        _userData.value =
            UserModel.fromDocumentSnapshot(snapshot: documentSnapshot);
        // _userData.value = getUserDataWithStream();
        // print('Document exists on the database');
        // print(documentSnapshot.data());
      } else {
        print("User document not found");
      }
    });
    // _userData.value =
    //     UserModel(id: _firebaseUser.value!.uid.toString(), thisUser: true);
  }

  // Future<Stream<DocumentSnapshot<Map<String, dynamic>>>>
  //     getUserDataWithStream() async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       ;
  // }

  linkEmail() async {
    // _firebaseUser.
    try {
      showLoading();
      var _googleAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth =
          await _googleAccount!.authentication;
      final googelCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _auth.currentUser!.linkWithCredential(googelCredential).then((user) {
        _auth.userChanges();

        dismissLoadingWidget();
        Get.to(() => EmailVerificationScreen());
        showSnackBar("Email Added Sucessfully", "");
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
    } catch (ex) {
      dismissLoadingWidget();
      //if account not merge]
      showErrorSnackBar();
    }
  }
}
