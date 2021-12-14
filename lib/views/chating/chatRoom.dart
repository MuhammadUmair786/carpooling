import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpooling_app/controllers/bottomNavBarController.dart';
import 'package:carpooling_app/models/userModel.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatelessWidget {
  // final Map<String, dynamic> userMap;
  final UserModel user;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.user});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String thisUserName = Get.find<BottomNavBarController>().getUser!.name;

  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    await _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": thisUserName,
      //  _auth.currentUser!.displayName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref = FirebaseStorage.instance
        .ref()
        .child('chatImages')
        .child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": thisUserName,
        // _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: Get.width,
            alignment: Alignment.topLeft,
            child: StreamBuilder<DocumentSnapshot>(
              stream: _firestore.collection("users").doc(user.id).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 25,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          iconSize: 20,
                          icon: Icon(Icons.arrow_back_rounded),
                          splashRadius: 15,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CachedNetworkImage(
                        imageUrl: user.img ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-zsO-WB5sqXt2_4XGhgNqeecBwQ2dm2dTFcV4NBR0hBIK9nlKRuIz8HUwEo-eEteJBm4&usqp=CAU",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                          strokeWidth: 2,
                        ),
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(user.name),
                          CustomText(
                            text: user.name,
                            size: 18,
                            weight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: snapshot.data!['status'],
                            size: 14,
                            weight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
        // title: StreamBuilder<DocumentSnapshot>(
        //   stream: _firestore.collection("users").doc(user.id).snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.data != null) {
        //       return Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           IconButton(
        //             onPressed: () {
        //               Get.back();
        //             },
        //             icon: Icon(Icons.arrow_back_rounded),
        //             splashRadius: 20,
        //           ),
        //           // const SizedBox(width: 10),
        //           CachedNetworkImage(
        //             imageUrl: user.img ??
        //                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-zsO-WB5sqXt2_4XGhgNqeecBwQ2dm2dTFcV4NBR0hBIK9nlKRuIz8HUwEo-eEteJBm4&usqp=CAU",
        //             imageBuilder: (context, imageProvider) => Container(
        //               width: 40.0,
        //               height: 40.0,
        //               decoration: BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 image: DecorationImage(
        //                     image: imageProvider, fit: BoxFit.cover),
        //               ),
        //             ),
        //             progressIndicatorBuilder:
        //                 (context, url, downloadProgress) =>
        //                     CircularProgressIndicator(
        //               value: downloadProgress.progress,
        //               strokeWidth: 2,
        //             ),
        //             // placeholder: (context, url) => CircularProgressIndicator(),
        //             errorWidget: (context, url, error) => Icon(Icons.error),
        //           ),
        //           const SizedBox(width: 10),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(user.name),
        //               Text(
        //                 snapshot.data!['status'],
        //                 style: TextStyle(fontSize: 14),
        //               ),
        //             ],
        //           ),
        //         ],
        //       );
        //     } else {
        //       return Container();
        //     }
        //   },
        // ),
      ),
      body: Container(
        height: Get.height -
            MediaQuery.of(context).padding.top -
            AppBar().preferredSize.height,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Container(
            //   height: size.height / 1.25,
            //   width: size.width,
            // child:
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroom')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return Expanded(
                    child:

                        //  ListView(children: [
                        //    for(int i = 0;i<snapshot.data!.docs.length;i++){
                        //      return messages(size, map, context);
                        //    }.toList()
                        //  ]
                        //  ,)
                        //  return ListView(
                        //   children: sSnapshot.data!.docs
                        //       .map((DocumentSnapshot myChat) {
                        //     for (DocumentSnapshot d
                        //         in allChats) {
                        //       if (myChat["id"] == d.id) {
                        //         ChatRoom chatRoom =
                        //             ChatRoom.fromMap(d.data());
                        //         return ChatTile(
                        //             chatRoom, userID);
                        //       }
                        //     }
                        //   }).toList(),
                        // );

                        ListView.builder(
                      shrinkWrap: true,
                      // reverse: true,
                      controller: _scrollController,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            // ),
            // Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => getImage(),
                            icon: Icon(Icons.photo),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          hintText: "Send Message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.send),
                      splashRadius: 25,
                      onPressed: onSendMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Container(
            width: 50,

            // size.width / 1.5,
            alignment: map['sendby'] == thisUserName

                // _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: map['sendby'] == thisUserName

                    // _auth.currentUser!.displayName
                    ? Colors.blue.withOpacity(0.6)
                    : Colors.green.withOpacity(0.6),
              ),
              child: Text(
                map['message'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sendby'] == thisUserName

                // _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: map['message'],
                  ),
                ),
              ),
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                alignment: map['sendby'] == thisUserName

                    // _auth.currentUser!.displayName
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                // alignment: map['message'] != "" ? null : Alignment.center,
                child: map['message'] != ""
                    ? Image.network(
                        map['message'],
                        fit: BoxFit.cover,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

//
