// import 'package:chat_app/Authenticate/Methods.dart';
// import 'package:chat_app/Screens/ChatRoom.dart';
// import 'package:chat_app/group_chats/group_chat_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpooling_app/controllers/bottomNavBarController.dart';
import 'package:carpooling_app/models/userModel.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chatRoom.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome>
// with WidgetsBindingObserver

{
  // Map<String, dynamic>? userMap;
  bool isLoading = true;
  // final TextEditingController _search = TextEditingController();

  var chatList = Get.find<BottomNavBarController>().getUser!.chatList;

  List<UserModel>? chatUserList = [];

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
// isLoading = true
    if (chatList.length > 0) {
      for (int i = 0; i < chatList.length; i++) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(chatList[i]['id'])
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
          if (documentSnapshot.exists) {
            chatUserList!.add(
                UserModel.fromDocumentSnapshot(snapshot: documentSnapshot));
          }
        }).then((value) {
          setState(() {
            isLoading = false;
          });
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
  // void setStatus(String status) async {
  //   await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
  //     "status": status,
  //   });
  // }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     // online
  //     setStatus("Online");
  //   } else {
  //     // offline
  //     setStatus("Offline");
  //   }
  // }
  // String chatRoomId(String user1, String user2) {
  //   if (user1[0].toLowerCase().codeUnits[0] >
  //       user2.toLowerCase().codeUnits[0]) {
  //     return "$user1$user2";
  //   } else {
  //     return "$user2$user1";
  //   }
  // }

  // void onSearch() async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await _firestore
  //       .collection('users')
  //       .where("email", isEqualTo: _search.text)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       userMap = value.docs[0].data();
  //       isLoading = false;
  //     });
  //     print(userMap);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : chatUserList!.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatUserList!.length,
                  itemBuilder: (con, index) {
                    return chatItem(
                        chatUserList![index], chatList[index]['roomID']);
                  },
                )
              : Center(
                  child: CustomText(
                    text: "No Chat Find",
                    size: 18,
                    weight: FontWeight.w500,
                  ),
                ),
    );
  }

  InkWell chatItem(UserModel user, String roomID) {
    return InkWell(
      onTap: () {
        Get.to(() => ChatRoom(chatRoomId: roomID, user: user));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: user.img ??
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-zsO-WB5sqXt2_4XGhgNqeecBwQ2dm2dTFcV4NBR0hBIK9nlKRuIz8HUwEo-eEteJBm4&usqp=CAU",
              imageBuilder: (context, imageProvider) => Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                strokeWidth: 2,
              ),
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: user.name,
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    // Icon(Icons.location_pin),
                    Container(
                      width: Get.width / 1.5,
                      child: Text(
                        "Hi, i am using carpooling",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Spacer(),
            // Icon(Icons.message, size: 35)
          ],
        ),
      ),
    );
  }
}
