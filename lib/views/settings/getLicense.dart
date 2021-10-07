import 'dart:io';

import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetLicense extends StatefulWidget {
  final bool isreadonly;

  GetLicense({required this.isreadonly});

  @override
  State<GetLicense> createState() => _GetLicenseState();
}

class _GetLicenseState extends State<GetLicense> {
  final TextEditingController _areaController =
      TextEditingController(text: "Punjab");

  final TextEditingController _licenseController = TextEditingController();

  final TextEditingController _vehicleController = TextEditingController();

  File? _image;

  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool showImgError = false;

  @override
  Widget build(BuildContext context) {
    const _textStyle = TextStyle(
      fontSize: 20,
      // fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("License Verification"),
        // centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            alignment: Alignment.center,
            child: CustomText(
              text: "Verified", //verified, failed
              color: Colors.white,
            ),
          )
        ],
      ),
      // height: Get.height -
      //     MediaQuery.of(context).padding.top -
      //     AppBar().preferredSize.height,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          // height: Get.height -
          //     MediaQuery.of(context).padding.top -
          //     AppBar().preferredSize.height,
          // height: Get.height,
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const CustomText(
                  text: "Area",
                  // weight: FontWeight.bold,
                  size: 22,
                  color: Colors.blue,
                ),
              ),

              Container(
                height: 46,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.grey),
                child: Theme(
                  data: ThemeData(
                    textTheme: TextTheme(subtitle1: _textStyle),
                  ),
                  child: DropdownSearch<String>(
                    // .collapsed(hintText: "Province",border: Border.),
                    popupBackgroundColor: Colors.grey,
                    // popupBarrierColor: Colors.indigo,

                    // label: "Area",
                    // hint: "Choose your Area",

                    mode: Mode.MENU,

                    dropdownSearchDecoration: InputDecoration(
                      hintText: 'Choose your Area',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                      fillColor: Colors.grey,
                      filled: true,
                      // border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    ),
                    // searchBoxStyle: _textStyle,
                    // searchBoxDecoration: InputDecoration(
                    //   hintText: "Search",
                    //   hintStyle: _textStyle,
                    //   border: OutlineInputBorder(),
                    // ),
                    // showSearchBox: true,
                    showSelectedItem: true,
                    // dropDownButton: Text(""),
                    // popupBackgroundColor: Colors.lime,
                    // searchBoxStyle:
                    //     TextStyle(fontSize: 25, color: Colors.lightGreen),
                    items: [
                      "Punjab",
                      "Federal",
                      "Sindh",
                      "KPK",
                      "AJK",
                      "Balochistan"
                    ],
                    // popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (value) {
                      _areaController.text = value!;
                    },
                    // selectedItem: "Punjab",
                  ),
                ),
              ),
              // SizedBox(height: 25),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const CustomText(
                  text: "License",
                  // weight: FontWeight.bold,
                  size: 22,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                readOnly: widget.isreadonly,
                controller: _licenseController,
                style: _textStyle,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                decoration: InputDecoration(
                  hintText: 'Enter License number',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                  fillColor: Colors.grey,
                  filled: true,
                  errorStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '???';
                  }
                  return null;
                },
              ),
              // SizedBox(height: 25),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const CustomText(
                  text: "Vehicle",
                  // weight: FontWeight.bold,
                  size: 22,
                  color: Colors.blue,
                ),
              ),
              InkWell(
                onTap: () async {
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
                                  licenseVehiclesBottomSheetItem(
                                      Icons.motorcycle, Colors.blue, "Bike"),
                                  licenseVehiclesBottomSheetItem(
                                      Icons.time_to_leave_rounded,
                                      Colors.green,
                                      "Car"),
                                  licenseVehiclesBottomSheetItem(
                                      Icons.all_inclusive, Colors.red, "Both"),
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
                child: AbsorbPointer(
                  child: TextFormField(
                    maxLines: null,
                    controller: _vehicleController,
                    // style: TextStyle(fontSize: 22),
                    style: _textStyle,
                    decoration: InputDecoration(
                      hintText: 'Authorized Vehicle',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                      fillColor: Colors.grey,
                      filled: true,
                      errorStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    ),
                    // decoration: InputDecoration(
                    //   // hintText: 'Choose your Vehicles',
                    //   // hintStyle: TextStyle(fontSize: 16),
                    //   labelText: "Authorized Vehicle",
                    //   // labelStyle: TextStyle(fontSize: 20),
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(3),
                    //     borderSide: BorderSide(
                    //       width: 0.5,
                    //       style: BorderStyle.none,
                    //     ),
                    //   ),
                    //   contentPadding:
                    //       EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    // ),
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Enter the time of your departure';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
              ),
              // SizedBox(height: 20),

              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const CustomText(
                  text: "Upload Image",
                  // weight: FontWeight.bold,
                  size: 22,
                  color: Colors.blue,
                ),
              ),
              // const SizedBox(height: 15),
              Container(
                // height: 170,
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
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
                                        "Camera"),
                                    getImgBottomSheetItem(
                                        Icons.image,
                                        Colors.green,
                                        ImageSource.gallery,
                                        "Gallery"),
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
                            width: Get.width / 3,
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
                                      "Front Side of License",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
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
                          height: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.file(_image!, fit: BoxFit.fill),
                        ),
                ),
              ),
              if (showImgError)
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    text: "upload License Images",
                    color: Colors.red,
                  ),
                ),

              // Spacer(),
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
            if (_formKey.currentState!.validate() && _image != null) {
              UserDatabase.addLicense(
                  area: _areaController.text,
                  license: _licenseController.text,
                  vehicle: _vehicleController.text,
                  image: _image!);
            }
            if (_image == null) {
              setState(() {
                showImgError = true;
              });
            }
          },
          child: CustomText(
            text: "Submit Details",
            size: 20,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  InkWell licenseVehiclesBottomSheetItem(
      IconData icon, Color col, String title) {
    return InkWell(
      onTap: () {
        _vehicleController.text = title;
        Get.back();
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
