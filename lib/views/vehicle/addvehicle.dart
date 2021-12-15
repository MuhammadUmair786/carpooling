import 'dart:io';

import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/widgets/custom_text.dart';

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
    true,
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
    true,
    false,
  ];
  // bool isAC = false;

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
  List<String> yearList = [];

  Color selectedColor = Colors.teal;
  IconData vehicleIcon = Icons.time_to_leave;
  bool isBike = false;
  TextEditingController _companyController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _colorController =
      TextEditingController(text: "4278190080");
  TextEditingController _engineController = TextEditingController();
  TextEditingController _engineTypeController = TextEditingController();
  TextEditingController _alphaTypeController = TextEditingController();
  TextEditingController _numericPartController = TextEditingController();
  TextEditingController _milageController = TextEditingController();

  File? _image;

  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool showImgError = false;

  @override
  void initState() {
    super.initState();
    for (int i = DateTime.now().year; i >= 1985; i--) {
      yearList.add(i.toString());
    }
  }

  _dropDown(String hint, List<String> itemList,
      TextEditingController controller, bool showSearch) {
    return Theme(
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
        showSearchBox: showSearch,
        dropdownSearchDecoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16, color: Colors.black),
          fillColor: Colors.grey[200],
          errorStyle: TextStyle(fontSize: 18),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.1, horizontal: 15),
        ),
        validator: (value) {
          if (value == null) {
            return '???';
          }
          if (value.isEmpty) {
            return '???';
          }
          return null;
        },
        maxHeight: itemList.length <= 4 ? itemList.length * 60 : 300,
        showSelectedItem: true,
        items: itemList,
        onChanged: (value) {
          controller.text = value!;
        },
      ),
    );
  }

  _textFormFeiled(
      TextEditingController cont,
      String hint,
      int length,
      TextInputType keyboard,
      String matching,
      TextCapitalization textCapitalization) {
    return TextFormField(
      controller: cont,
      textInputAction: TextInputAction.next,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(matching),
        ),
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
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      ),
      keyboardType: keyboard,
      textCapitalization: textCapitalization,
      validator: (value) {
        if (value!.isEmpty) {
          return '???';
        }
        // if (hint == "Model" &&
        //     (int.parse(value) < 1970 ||
        //         int.parse(value) > DateTime.now().year)) {
        //   return "not a valid Model";
        // }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF4793E),
        title: Text(
          "Register Your Vehicle",
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                // color: Colors.blue.withOpacity(0.5),
                alignment: Alignment.center,
                child: ToggleButtons(
                  borderColor: Colors.transparent,
                  fillColor: selectedColor.withOpacity(0.09),
                  borderWidth: 10,
                  selectedBorderColor: Colors.transparent,
                  // borderRadius: BorderRadius.circular(10),
                  // renderBorder: false,
                  children: <Widget>[
                    chooseVehicleItem(
                        Icons.time_to_leave, Colors.orange, "Car"),
                    chooseVehicleItem(
                        Icons.directions_bike, Colors.deepPurpleAccent, "Bike"),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < vehicleSelectedList.length; i++) {
                        vehicleSelectedList[i] = i == index;
                      }
                      if (index == 0) {
                        vehicleIcon = Icons.time_to_leave;
                        isBike = false;
                        // Get.back();
                        // Get.off(() => AddVehicle());
                        // _companyController.clear();
                        // _engineTypeController.clear();
                        // _engineController.clear();
                      } else {
                        vehicleIcon = Icons.directions_bike;
                        isBike = true;
                        // Get.back();
                        // Get.off(() => AddVehicle());
                        // _companyController.clear();
                        // _engineTypeController.clear();
                        // _engineController.clear();
                      }
                    });
                  },
                  isSelected: vehicleSelectedList,
                ),
              ),
              _dropDown("Company", isBike ? bikeCompanyList : carCompanyList,
                  _companyController, false),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _textFormFeiled(
                        _modelController,
                        "Model",
                        15,
                        TextInputType.text,
                        "[A-Za-z0-9 .]",
                        TextCapitalization.words),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: _dropDown("Year", yearList, _yearController, true),
                  )
                ],
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
                            print(Colors.black.value.toString());
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
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isBike)
                    Expanded(
                      child: _dropDown("Engine Type", ["Hybrid", "Non-Hybrid"],
                          _engineTypeController, false),
                    ),
                  if (!isBike) SizedBox(width: 5),
                  Expanded(
                    child: _dropDown(
                        "Engine",
                        isBike ? bikeEngineList : carEngineList,
                        _engineController,
                        true),
                  )
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _textFormFeiled(
                        _alphaTypeController,
                        "Alphabets (RIW)",
                        3,
                        TextInputType.name,
                        "[A-Z]",
                        TextCapitalization.characters),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: _textFormFeiled(
                        _numericPartController,
                        "Numeric (2981)",
                        4,
                        TextInputType.number,
                        "[0-9]",
                        TextCapitalization.none),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              _textFormFeiled(_milageController, "Milage (24 KM/L)", 2,
                  TextInputType.number, "[0-9]", TextCapitalization.none),
              Container(
                // height: 170,
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      SafeArea(
                        child: Container(
                          height: 160,
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
                                    vertical: 10, horizontal: 40),
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
                              ),
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
                            width: Get.width / 2.3,
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      showImgError ? Colors.red : Color(0xFFF4793E)),
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
                                    color: Color(0xFFF4793E),
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
                Center(
                  child: CustomText(
                    text: "Upload Vehicle Image",
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
            primary: Color(0xFFF4793E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          onPressed: () {
// GetStorage box = GetStorage();
            // print(_companyController.text);
            if (
                // isBike &&
                _formKey.currentState!.validate() && _image != null) {
              UserDatabase.addVehicle(
                  vehicleType: isBike ? "Bike" : "Car",
                  company: _companyController.text,
                  model: _modelController.text,
                  year: _yearController.text,
                  color: _colorController.text,
                  engine: _engineController.text,
                  engineType: isBike ? "" : _engineTypeController.text,
                  noAlp: _alphaTypeController.text,
                  noNum: _numericPartController.text,
                  milage: _milageController.text,
                  image: _image);
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
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // _colorController.text = col.value.toString();
  Widget chooseVehicleItem(IconData icon, Color col, String title) {
    return Container(
      // height: 60,
      // width: 70,
      // margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: col, width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: col,
            size: 30,
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
            showImgError = false;
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
