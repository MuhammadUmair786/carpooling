import 'package:carpooling_app/views/bottomnavbar.dart';
import 'package:carpooling_app/views/login.dart';
import 'package:carpooling_app/views/rides/tempMapSearchScreen.dart';
// import 'package:carpooling_app/views/rides/tempSearch.dart';

import 'package:carpooling_app/widgets/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late Widget startingWidget;
    if (FirebaseAuth.instance.currentUser != null) {
      Get.put(AuthController(), permanent: true);
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
    );
  }
}

// import 'dart:async';
// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:dash_chat/dash_chat.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

//   final ChatUser user = ChatUser(
//     name: "Fayeed",
//     uid: "123456789",
//     avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
//   );

//   final ChatUser otherUser = ChatUser(
//     name: "Mrfatty",
//     uid: "25649654",
//   );

//   List<ChatMessage> messages = <ChatMessage>[];
//   var m = <ChatMessage>[];

//   var i = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void systemMessage() {
//     Timer(Duration(milliseconds: 300), () {
//       if (i < 6) {
//         setState(() {
//           messages = [...messages, m[i]];
//         });
//         i++;
//       }
//       Timer(Duration(milliseconds: 300), () {
//         _chatViewKey.currentState!.scrollController
//           ..animateTo(
//             _chatViewKey
//                 .currentState!.scrollController.position.maxScrollExtent,
//             curve: Curves.easeOut,
//             duration: const Duration(milliseconds: 300),
//           );
//       });
//     });
//   }

//   void onSend(ChatMessage message) {
//     print(message.toJson());
//     FirebaseFirestore.instance
//         .collection('messages')
//         .doc(DateTime.now().millisecondsSinceEpoch.toString())
//         .set(message.toJson());
//     /* setState(() {
//       messages = [...messages, message];
//       print(messages.length);
//     });

//     if (i == 0) {
//       systemMessage();
//       Timer(Duration(milliseconds: 600), () {
//         systemMessage();
//       });
//     } else {
//       systemMessage();
//     } */
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chat App"),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('messages')
//               .orderBy("createdAt")
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     Theme.of(context).primaryColor,
//                   ),
//                 ),
//               );
//             } else {
//               List<DocumentSnapshot<Map<dynamic, dynamic>>> items =
//                   snapshot.data!.docs.cast<DocumentSnapshot<Map>>();
//               var messages =
//                   items.map((i) => ChatMessage.fromJson(i.data()!)).toList();
//               return DashChat(
//                 key: _chatViewKey,
//                 inverted: false,
//                 onSend: onSend,
//                 sendOnEnter: true,
//                 textInputAction: TextInputAction.send,
//                 user: user,
//                 inputDecoration:
//                     InputDecoration.collapsed(hintText: "Add message here..."),
//                 dateFormat: DateFormat('yyyy-MMM-dd'),
//                 timeFormat: DateFormat('HH:mm'),
//                 messages: messages,
//                 showUserAvatar: false,
//                 showAvatarForEveryMessage: false,
//                 scrollToBottom: false,
//                 onPressAvatar: (ChatUser user) {
//                   print("OnPressAvatar: ${user.name}");
//                 },
//                 onLongPressAvatar: (ChatUser user) {
//                   print("OnLongPressAvatar: ${user.name}");
//                 },
//                 inputMaxLines: 5,
//                 messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
//                 alwaysShowSend: true,
//                 inputTextStyle: TextStyle(fontSize: 16.0),
//                 inputContainerStyle: BoxDecoration(
//                   border: Border.all(width: 0.0),
//                   color: Colors.white,
//                 ),
//                 onQuickReply: (Reply reply) {
//                   setState(() {
//                     messages.add(ChatMessage(
//                         text: reply.value,
//                         createdAt: DateTime.now(),
//                         user: user));

//                     messages = [...messages];
//                   });

//                   Timer(Duration(milliseconds: 300), () {
//                     _chatViewKey.currentState!.scrollController
//                       ..animateTo(
//                         _chatViewKey.currentState!.scrollController.position
//                             .maxScrollExtent,
//                         curve: Curves.easeOut,
//                         duration: const Duration(milliseconds: 300),
//                       );

//                     if (i == 0) {
//                       systemMessage();
//                       Timer(Duration(milliseconds: 600), () {
//                         systemMessage();
//                       });
//                     } else {
//                       systemMessage();
//                     }
//                   });
//                 },
//                 onLoadEarlier: () {
//                   print("laoding...");
//                 },
//                 shouldShowLoadEarlier: false,
//                 showTraillingBeforeSend: true,
//                 trailing: <Widget>[
//                   IconButton(
//                     icon: Icon(Icons.photo),
//                     onPressed: () async {
//                       final picker = ImagePicker();
//                       PickedFile? result = await picker.getImage(
//                         source: ImageSource.gallery,
//                         imageQuality: 80,
//                         maxHeight: 400,
//                         maxWidth: 400,
//                       );

//                       if (result != null) {
//                         final Reference storageRef =
//                             FirebaseStorage.instance.ref().child("chat_images");

//                         final taskSnapshot = await storageRef.putFile(
//                           File(result.path),
//                           SettableMetadata(
//                             contentType: 'image/jpg',
//                           ),
//                         );

//                         String url = await taskSnapshot.ref.getDownloadURL();

//                         ChatMessage message =
//                             ChatMessage(text: "", user: user, image: url);

//                         FirebaseFirestore.instance
//                             .collection('messages')
//                             .add(message.toJson());
//                       }
//                     },
//                   )
//                 ],
//               );
//             }
//           }),
//     );
//   }
// }



//
//////
/////////
///////
///////////
//////////////
///////
/////
/////
/////
/////
///
///
///
///

// import 'dart:async';
// import 'dart:math';

// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';

// const kGoogleApiKey = "API_KEY";

// main() {
//   runApp(RoutesWidget());
// }

// final customTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   brightness: Brightness.dark,
//   accentColor: Colors.redAccent,
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(4.00)),
//     ),
//     contentPadding: EdgeInsets.symmetric(
//       vertical: 12.50,
//       horizontal: 10.00,
//     ),
//   ),
// );

// class RoutesWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         title: "My App",
//         theme: customTheme,
//         routes: {
//           "/": (_) => MyApp(),
//           "/search": (_) => CustomSearchScaffold(),
//         },
//       );
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// final homeScaffoldKey = GlobalKey<ScaffoldState>();
// final searchScaffoldKey = GlobalKey<ScaffoldState>();

// class _MyAppState extends State<MyApp> {
//   Mode _mode = Mode.overlay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         title: Text("My App"),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _buildDropdownMenu(),
//           ElevatedButton(
//             onPressed: _handlePressButton,
//             child: Text("Search places"),
//           ),
//           ElevatedButton(
//             child: Text("Custom"),
//             onPressed: () {
//               Navigator.of(context).pushNamed("/search");
//             },
//           ),
//         ],
//       )),
//     );
//   }

//   Widget _buildDropdownMenu() => DropdownButton(
//         value: _mode,
//         items: <DropdownMenuItem<Mode>>[
//           DropdownMenuItem<Mode>(
//             child: Text("Overlay"),
//             value: Mode.overlay,
//           ),
//           DropdownMenuItem<Mode>(
//             child: Text("Fullscreen"),
//             value: Mode.fullscreen,
//           ),
//         ],
//         onChanged: (m) {
//           setState(() {
//             _mode = m as Mode;
//           });
//         },
//       );

//   void onError(PlacesAutocompleteResponse response) {
//     homeScaffoldKey.currentState!.showSnackBar(
//       SnackBar(content: Text(response.errorMessage.toString())),
//     );
//   }

//   Future<void> _handlePressButton() async {
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     Prediction? p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: kGoogleApiKey,
//       onError: onError,
//       mode: _mode,
//       language: "fr",
//       decoration: InputDecoration(
//         hintText: 'Search',
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       components: [Component(Component.country, "fr")],
//     );

//     displayPrediction(p!, homeScaffoldKey.currentState);
//   }
// }

// Future<Null> displayPrediction(Prediction p, ScaffoldState? scaffold) async {
//   if (p != null) {
//     // get detail (lat/lng)
//     GoogleMapsPlaces _places = GoogleMapsPlaces(
//       apiKey: kGoogleApiKey,
//       apiHeaders: await GoogleApiHeaders().getHeaders(),
//     );
//     PlacesDetailsResponse detail =
//         await _places.getDetailsByPlaceId(p.placeId.toString());
//     final lat = detail.result.geometry!.location.lat;
//     final lng = detail.result.geometry!.location.lng;

//     scaffold!.showSnackBar(
//       SnackBar(content: Text("${p.description} - $lat/$lng")),
//     );
//   }
// }

// // custom scaffold that handle search
// // basically your widget need to extends [GooglePlacesAutocompleteWidget]
// // and your state [GooglePlacesAutocompleteState]
// class CustomSearchScaffold extends PlacesAutocompleteWidget {
//   CustomSearchScaffold()
//       : super(
//           apiKey: kGoogleApiKey,
//           sessionToken: Uuid().generateV4(),
//           language: "en",
//           components: [Component(Component.country, "uk")],
//         );

//   @override
//   _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
// }

// class _CustomSearchScaffoldState extends PlacesAutocompleteState {
//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
//     final body = PlacesAutocompleteResult(
//       onTap: (p) {
//         displayPrediction(p, searchScaffoldKey.currentState);
//       },
//       logo: Row(
//         children: [FlutterLogo()],
//         mainAxisAlignment: MainAxisAlignment.center,
//       ),
//     );
//     return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
//   }

//   @override
//   void onResponseError(PlacesAutocompleteResponse response) {
//     super.onResponseError(response);
//     searchScaffoldKey.currentState!.showSnackBar(
//       SnackBar(content: Text(response.errorMessage.toString())),
//     );
//   }

//   @override
//   void onResponse(PlacesAutocompleteResponse? response) {
//     super.onResponse(response);
//     if (response != null && response.predictions.isNotEmpty) {
//       searchScaffoldKey.currentState!.showSnackBar(
//         SnackBar(content: Text("Got answer")),
//       );
//     }
//   }
// }

// class Uuid {
//   final Random _random = Random();

//   String generateV4() {
//     // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
//     final int special = 8 + _random.nextInt(4);

//     return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
//         '${_bitsDigits(16, 4)}-'
//         '4${_bitsDigits(12, 3)}-'
//         '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
//         '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
//   }

//   String _bitsDigits(int bitCount, int digitCount) =>
//       _printDigits(_generateBits(bitCount), digitCount);

//   int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

//   String _printDigits(int value, int count) =>
//       value.toRadixString(16).padLeft(count, '0');
// }
