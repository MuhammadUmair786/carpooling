import 'package:carpooling_app/views/bottomnavbar.dart';
import 'package:carpooling_app/views/login.dart';
import 'package:carpooling_app/views/rides/tempMapSearchScreen.dart';
// import 'package:carpooling_app/views/rides/tempSearch.dart';

import 'package:carpooling_app/widgets/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import 'constants/firebase.dart';
// import 'controllers/authController.dart';
// import 'widgets/searchLocation.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
//   print('Handling a background message ${message.messageId}');
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late Widget startingWidget;
    if (FirebaseAuth.instance.currentUser != null) {
      // Get.put(AuthController(), permanent: true);
      startingWidget = BottomNavBar();
    } else {
      startingWidget = Login();
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Carpooling",
      theme: MyThemes.lightTheme,
      home:
          // MapPage(),

          startingWidget,
      // SearchLocation(),
    );
  }
}
