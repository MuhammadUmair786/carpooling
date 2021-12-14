import 'dart:io';

import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadUserImage extends StatefulWidget {
  @override
  State<UploadUserImage> createState() => _UploadUserImageState();
}

class _UploadUserImageState extends State<UploadUserImage> {
  bool showImgError = false;

  File? _image;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    const _textStyle = TextStyle(
      fontSize: 20,
      // fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 04,
        title: Text("Upload Profile Image"),
        // centerTitle: true,
        // actions: [
        //   Container(
        //       margin: EdgeInsets.only(right: 15),
        //       alignment: Alignment.center,
        //       child: CustomText(
        //         text: "Pending", //verified, failed
        //         color: Colors.white,
        //       ))
        // ],
      ),
      body: Material(
        // color: Colors.teal,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              // const SizedBox(height: 25),
              // Container(
              //   alignment: Alignment.topLeft,
              //   margin: const EdgeInsets.symmetric(vertical: 10),
              //   child: const CustomText(
              //     text: "Upload Image",
              //     // weight: FontWeight.bold,
              //     size: 22,
              //     color: Colors.blue,
              //   ),
              // ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    SafeArea(
                      child: Container(
                        height: 180,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 5,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  getImgBottomSheetItem(
                                    Icons.camera,
                                    Colors.blue,
                                    ImageSource.camera,
                                    "Camera",
                                  ),
                                  getImgBottomSheetItem(
                                    Icons.image,
                                    Colors.green,
                                    ImageSource.gallery,
                                    "Gallery",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  );
                },
                child: _image == null
                    ? Center(
                        child: Container(
                          width: Get.width / 2.5,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  // width: 30,
                                  child: Text(
                                    "Upload Your Profile Image",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  // CustomText(
                                  //   text: "Front Side of CNIC",
                                  //   size: 14,
                                  //   weight: FontWeight.bold,
                                  //   color: Colors.blue,
                                  // ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.cloud_upload_rounded,
                                  size: 35,
                                  color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: Get.height * 0.7,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.file(_image!, fit: BoxFit.fill),
                      ),
              ),
              if (showImgError)
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    text: "Image not selected",
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(Get.width / 1.5, 40),
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          onPressed: () {
            if (_image != null) {
              UserDatabase.addUserImage(image: _image!).then((value) {
                Get.back();
              });
            }
            if (_image == null) {
              setState(() {
                showImgError = true;
              });
            }
          },
          child: const CustomText(
            text: "Upload Image",
            size: 20,
            // weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  InkWell getImgBottomSheetItem(
      IconData icon, Color col, ImageSource source, String title) {
    return InkWell(
      onTap: () async {
        Get.back();
        final pickedFile = await picker.getImage(
            source: ImageSource.gallery, imageQuality: 50);

        setState(() {
          if (pickedFile != null) {
            _image = File(pickedFile.path);
          } else {
            print('No image selected.');
          }
        });
      },
      splashColor: col.withOpacity(0.5),
      child: Container(
        decoration: new BoxDecoration(
          border: Border.all(color: col, width: 3.5),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(20),
        // margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Icon(
              icon,
              color: col,
              size: 30,
            ),
            CustomText(
              text: title,
              color: col,
            )
          ],
        ),
      ),
    );
  }
}
