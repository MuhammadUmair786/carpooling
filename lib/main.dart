import 'package:carpooling_app/views/bottomnavbar.dart';
import 'package:carpooling_app/views/login.dart';
import 'package:carpooling_app/views/startingdetails.dart';
// import 'package:carpooling_app/views/rides/ride_filters.dart';
// import 'package:carpooling_app/views/rides/seacrh_ride.dart';
// import 'package:carpooling_app/views/startingdetails.dart';
// import 'package:carpooling_app/views/search.dart';
import 'package:carpooling_app/widgets/theme.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import 'constants/firebase.dart';
import 'controllers/authController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });

  // WidgetsFlutterBinding.ensureInitialized();

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = Get.put(AuthController(), permanent: true);
    // _documentExist() async {
    //   var docRef = await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(_controller.user!.uid)
    //       .get();
    //   if (docRef.exists) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }

    Widget startingWidget;
    if (_controller.user != null) {
      // Future<bool> result = _documentExist();
      //if userdocument exist then go to home
      // if (result == true) {
      startingWidget = BottomNavBar();
      // }
      //otherwise go to starting document for egtting starting details
      // else {
      // startingWidget = StartingDetails();
      // }
    } else {
      startingWidget = Login();
    }
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Carpooling",
        theme: MyThemes.lightTheme,
        home:
            // Search()
            startingWidget
        // SearchRide()
        // RideFilter()
        // BottomNavBar(),
        );
  }
}
