import 'dart:io';

import 'package:carpooling_app/widgets/costEstimation.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';

class AddVehicle extends StatefulWidget {
  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  List<bool> colorSelectedList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> vehicleSelectedList = [
    false,
    false,
  ];
  bool isAC = false;

  List<String> carEngineList = [
    "800 CC",
    "1000 CC",
    "1300 CC",
    "1500 CC",
    "1800 CC",
    "2000 CC",
    "2500 CC",
    "2800 CC",
    "3000 CC",
  ];
  List<String> bikeEngineList = [
    "70 CC",
    "100 CC",
    "125 CC",
    "150 CC",
  ];

  List<String> carCompanyList = [
    "Honda",
    "Toyota",
    "Suzuki",
    "Other",
  ];
  List<String> bikeCompanyList = [
    "Honda",
    "Suzuki",
    "Yamaha",
    "Other",
  ];
  Color selectedColor = Colors.teal;
  IconData vehicleIcon = Icons.time_to_leave;
  bool isBike = false;
  TextEditingController _companyController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _engineController = TextEditingController();
  TextEditingController _engineTypeController = TextEditingController();
  TextEditingController _alphaTypeController = TextEditingController();
  TextEditingController _numericPartController = TextEditingController();
  TextEditingController _milageController = TextEditingController();

  File? _image;

  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool showImgError = false;

  _dropDown(
      String hint, List<String> itemList, TextEditingController controller) {
    return Container(
      height: 46,
      child: Theme(
        data: ThemeData(
          textTheme: TextTheme(
              subtitle1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
        ),
        child: DropdownSearch<String>(
          popupBackgroundColor: Colors.grey[300],
          mode: Mode.MENU,
          dropdownSearchDecoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 16, color: Colors.black),
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          ),
          maxHeight: itemList.length <= 3 ? itemList.length * 60 : 4 * 60,
          showSelectedItem: true,
          items: itemList,
          onChanged: (value) {
            controller.text = value!;
          },
        ),
      ),
    );
  }

  _textFormFeiled(TextEditingController cont, String hint, int length,
      TextInputType keyboard, String matching) {
    return SizedBox(
      // height: 53,
      child: TextFormField(
        controller: cont,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(matching)),
        ],
        maxLength: length,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16, color: Colors.black),
          fillColor: Colors.grey[200],
          filled: true,
          errorStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          counter: Offstage(),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        ),
        keyboardType: keyboard,
        textCapitalization: TextCapitalization.characters,
        validator: (value) {
          if (value!.isEmpty) {
            return '???';
          }
          if (hint == "Model" &&
              (int.parse(value) < 1970 ||
                  int.parse(value) > DateTime.now().year)) {
            return "not a valid Model";
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Register Your Vehicle",
          textScaleFactor: 1.2,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // color: Colors.yellow[100],
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: ToggleButtons(
                  borderColor: Colors.transparent,
                  fillColor: selectedColor.withOpacity(0.2),
                  borderWidth: 10,
                  selectedBorderColor: Colors.transparent,
                  // borderRadius: BorderRadius.circular(10),
                  // renderBorder: false,
                  children: <Widget>[
                    chooseVehicleItem(
                        Icons.time_to_leave, Colors.orange, "Car"),
                    chooseVehicleItem(
                        Icons.directions_bike, Colors.green, "Bike"),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < vehicleSelectedList.length; i++) {
                        vehicleSelectedList[i] = i == index;
                      }
                      if (index == 0) {
                        vehicleIcon = Icons.time_to_leave;
                        isBike = false;
                      } else {
                        vehicleIcon = Icons.directions_bike;
                        isBike = true;
                      }
                    });
                  },
                  isSelected: vehicleSelectedList,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _dropDown(
                        "Company",
                        isBike ? bikeCompanyList : carCompanyList,
                        _companyController),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _textFormFeiled(_modelController, "Model", 4,
                        TextInputType.number, "[0-9]"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    ToggleButtons(
                      borderColor: Colors.transparent,
                      fillColor: selectedColor.withOpacity(0.5),
                      borderWidth: 1,
                      borderRadius: BorderRadius.circular(10),
                      // renderBorder: false,
                      children: <Widget>[
                        vehicleColorItem(Colors.white),
                        vehicleColorItem(Colors.black),
                        vehicleColorItem((Colors.grey[800])!),
                        vehicleColorItem(Colors.blue),
                        vehicleColorItem(Colors.red),
                        vehicleColorItem(Colors.brown),
                        vehicleColorItem(Colors.orange),
                        vehicleColorItem(Colors.yellow),
                        vehicleColorItem(Colors.purple),
                        vehicleColorItem(Colors.green),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < colorSelectedList.length; i++) {
                            colorSelectedList[i] = i == index;
                          }
                          if (index == 0) {
                            _colorController.text =
                                Colors.white.value.toString();
                          } else if (index == 1) {
                            _colorController.text =
                                Colors.black.value.toString();
                          } else if (index == 2) {
                            _colorController.text =
                                Colors.grey[800]!.value.toString();
                          } else if (index == 3) {
                            _colorController.text =
                                Colors.blue.value.toString();
                          } else if (index == 4) {
                            _colorController.text = Colors.red.value.toString();
                          } else if (index == 5) {
                            _colorController.text =
                                Colors.brown.value.toString();
                          } else if (index == 6) {
                            _colorController.text =
                                Colors.orange.value.toString();
                          } else if (index == 7) {
                            _colorController.text =
                                Colors.yellow.value.toString();
                          } else if (index == 8) {
                            _colorController.text =
                                Colors.purple.value.toString();
                          } else if (index == 9) {
                            _colorController.text =
                                Colors.green.value.toString();
                          }
                          print(_colorController.text);
                        });
                      },
                      isSelected: colorSelectedList,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  if (!isBike)
                    Expanded(
                      flex: 6,
                      child: _dropDown("Engine Type", ["Hybrid", "Non-Hybrid"],
                          _engineTypeController),
                    ),
                  if (!isBike) SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: _dropDown(
                        "Engine",
                        isBike ? bikeEngineList : carEngineList,
                        _engineController),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: _textFormFeiled(_alphaTypeController,
                        "Alphabets (RIW)", 3, TextInputType.name, "[A-Z]"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _textFormFeiled(_numericPartController,
                        "Numeric (2981)", 4, TextInputType.number, "[0-9]"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _textFormFeiled(_milageController, "Milage (24 KM/L)", 2,
                  TextInputType.number, "[0-9]"),
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
                            width: Get.width / 2.5,
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.symmetric(vertical: 15),
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
                                      "Upload Your Vehicle Image",
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
                )
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
            if (

                // isBike &&

                _formKey.currentState!.validate()
                // && _image != null

                ) {
              print("bike");
              // UserDatabase.addWorkingDetails(data: {
              //   "type": "std",
              //   "institute": _instController.text,
              //   "adress": _stdAddressController.text,
              //   "degree": _degreeController.text,
              // });
              // _clearControlers();
            }
            //
            //else if (isEmployee && _empformKey.currentState!.validate()) {
            //   UserDatabase.addWorkingDetails(data: {
            //     "type": "emp",
            //     "company_name": _companyController.text,
            //     "adress": _empAddressController.text,
            //     "designation": _designationController.text,
            //   });
            //   _clearControlers();
            // } else if (isBusiness && _busiformKey.currentState!.validate()) {
            //   UserDatabase.addWorkingDetails(data: {
            //     "type": "business",
            //     "name": _businessNameController.text,
            //     "adress": _addressController.text,
            //   });
            //   _clearControlers();
            // }
            // if (_formKey.currentState!.validate() && _image != null) {
            //   UserDatabase.addLicense(
            //       area: _areaController.text,
            //       license: _licenseController.text,
            //       vehicle: _vehicleController.text,
            //       image: _image!);
            // }
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

  // _colorController.text = col.value.toString();
  Container chooseVehicleItem(IconData icon, Color col, String title) {
    return Container(
      // height: 60,
      // width: 70,
      // margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(color: col, width: 3),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: col,
            size: 35,
          ),
          SizedBox(width: 5),
          CustomText(
            text: title,
            color: col,
            size: 22,
            weight: FontWeight.bold,
          )
        ],
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

  Widget vehicleColorItem(Color col) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            vehicleIcon,
            color: col,
            size: 35,
          ),
        ],
      ),
    );
  }
}
