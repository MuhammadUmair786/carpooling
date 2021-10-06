import 'package:carpooling_app/widgets/costEstimation.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:dropdown_search/dropdown_search.dart';

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

  List<String> engineList = [
    "800 CC",
    "1000 CC",
    "1300 CC",
    "1500 CC",
    "1800 CC",
    "2000 CC",
    "2500 CC",
    "2800 CC",
    "3000 CC"
  ];
  List<String> carCompanyList = [
    "Honda",
    "Toyota",
    "Suzuki",
    "Other",
  ];
  List<String> bikeCompanyList = ["Honda", "Suzuki", "Yamaha", "Other"];
  Color selectedColor = Colors.teal;
  IconData vehicleIcon = Icons.time_to_leave;
  bool isBike = false;
  TextEditingController _carController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _engineController = TextEditingController();
  TextEditingController _engineTypeController = TextEditingController();
  TextEditingController _alphaTypeController = TextEditingController();
  TextEditingController _numericPartController = TextEditingController();
  TextEditingController _milageController = TextEditingController();

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
          popupBackgroundColor: Colors.grey[200],
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
          maxHeight: itemList.length * 60,
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
      height: 53,
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
  // int _value = 1;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Register Your Vehicle",
          textScaleFactor: 1.2,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: Get.width / 1.75,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://bestprofilepictures.com/wp-content/uploads/2020/06/Anonymous-Profile-Picture-1024x1024.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                      bottom: 5,
                      right: 5,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 40,
                      )),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    // vehicleIcon
                    // _dropDown(
                    //     "Vehicle Type", ["Car", "MotorCycle"], _carController),
                    // Container(
                    //   height: 46,
                    //   child: Theme(
                    //     data: ThemeData(
                    //       textTheme: TextTheme(
                    //           subtitle1: TextStyle(
                    //         fontSize: 20,
                    //         // fontWeight: FontWeight.w500,
                    //         color: Colors.white,
                    //       )),
                    //     ),
                    //     child: DropdownSearch<String>(
                    //       popupBackgroundColor: Colors.grey[400],
                    //       mode: Mode.MENU,
                    //       dropdownSearchDecoration: InputDecoration(
                    //         hintText: "Vehicle Type",
                    //         hintStyle:
                    //             TextStyle(fontSize: 16, color: Colors.white),
                    //         fillColor: Colors.grey,
                    //         filled: true,
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //           borderSide: BorderSide.none,
                    //         ),
                    //         contentPadding: EdgeInsets.symmetric(
                    //             vertical: 5, horizontal: 15),
                    //       ),
                    //       maxHeight: 2 * 60,
                    //       showSelectedItem: true,
                    //       items: ["Car", "MotorCycle"],
                    //       selectedItem: "Car",
                    //       onChanged: (value) {
                    //         _carController.text = value!;
                    //         setState(() {
                    //           if (value == "Car") {
                    //             vehicleIcon = Icons.time_to_leave;
                    //             isBike = false;
                    //           } else {
                    //             vehicleIcon = Icons.directions_bike;
                    //             isBike = true;
                    //           }
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 10),
                    //   child: const CustomText(
                    //     text: "Vehicle Type",
                    //     // weight: FontWeight.bold,
                    //     size: 22,
                    //     color: Colors.blue,
                    //   ),
                    // ),
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
                            for (int i = 0;
                                i < vehicleSelectedList.length;
                                i++) {
                              vehicleSelectedList[i] = i == index;
                            }
                            if (index == 0) {
                              vehicleIcon = Icons.time_to_leave;
                              isBike = false;
                            } else {
                              vehicleIcon = Icons.directions_bike;
                              isBike = true;
                            }
                            // if (index == 0) {
                            //   _statusController.text = "Student";
                            //   isStudent = true;
                            //   isEmployee = false;
                            //   isBusiness = false;
                            //   // widget.controller.text = "Male";
                            // } else if (index == 1) {
                            //   _statusController.text = "Employee";
                            //   isStudent = false;
                            //   isEmployee = true;
                            //   isBusiness = false;
                            //   // widget.controller.text = "Female";
                            // } else {
                            //   _statusController.text = "Business";
                            //   isStudent = false;
                            //   isEmployee = false;
                            //   isBusiness = true;
                            //   // widget.controller.text = "None";
                            // }
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
                              ["Honda", "Suzuki", "Toyotta"],
                              _companyController),

                          // DropdownSearch<String>(
                          //     searchBoxDecoration:
                          //         InputDecoration.collapsed(hintText: "Company"),
                          //     // showSearchBox: true,
                          //     mode: Mode.MENU,
                          //     showSelectedItem: true,
                          //     items: ["Honda", "Suzuki", "toyotta", 'mercendese'],
                          //     label: "Company",
                          //     popupItemDisabled: (String s) => s.startsWith('I'),
                          //     onChanged: print,
                          //     selectedItem: "honda"),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _textFormFeiled(_modelController, "Model", 4,
                              TextInputType.number, "[0-9]"),
                          //  _dropDown("Model", itemList, controller)
                          // DropdownSearch<String>(
                          //     mode: Mode.MENU,
                          //     showSelectedItem: true,
                          //     items: ["2000", "2001", "2002", '2003'],
                          //     label: "Model",
                          //     popupItemDisabled: (String s) =>
                          //         s.startsWith('I'),
                          //     onChanged: print,
                          //     selectedItem: "2000"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          ToggleButtons(
                            borderColor: Colors.transparent,
                            fillColor: selectedColor.withOpacity(0.8),
                            borderWidth: 1,
                            selectedColor: selectedColor,
                            selectedBorderColor: Colors.transparent,
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
                                for (int i = 0;
                                    i < colorSelectedList.length;
                                    i++) {
                                  colorSelectedList[i] = i == index;
                                }
                                if (index == 0) {}
                                // if (index == 0) {
                                //   _statusController.text = "Student";
                                //   isStudent = true;
                                //   isEmployee = false;
                                //   isBusiness = false;
                                //   // widget.controller.text = "Male";
                                // } else if (index == 1) {
                                //   _statusController.text = "Employee";
                                //   isStudent = false;
                                //   isEmployee = true;
                                //   isBusiness = false;
                                //   // widget.controller.text = "Female";
                                // } else {
                                //   _statusController.text = "Business";
                                //   isStudent = false;
                                //   isEmployee = false;
                                //   isBusiness = true;
                                //   // widget.controller.text = "None";
                                // }
                              });
                            },
                            isSelected: colorSelectedList,
                          )
                          // Expanded(
                          //   child: DropdownSearch<String>(
                          //       mode: Mode.MENU,
                          //       showSelectedItem: true,
                          //       items: ["blue", "white", "black", 'yellow'],
                          //       label: "Color",
                          //       popupItemDisabled: (String s) => s.startsWith('I'),
                          //       onChanged: print,
                          //       selectedItem: "black"),
                          // ),
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
                            child: _dropDown(
                                "Engine Type",
                                ["Hybrid", "Non-Hybrid"],
                                _engineTypeController),
                          ),
                        if (!isBike) SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: _dropDown(
                              "Engine", engineList, _engineController),
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
                              "Alphabets", 3, TextInputType.name, "[A-Z]"),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _textFormFeiled(_numericPartController,
                              "Numeric", 4, TextInputType.number, "[0-9]"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _textFormFeiled(_milageController, "Milage", 2,
                        TextInputType.number, "[0-9]"),
                  ],
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
            // if (isStudent && _stdformKey.currentState!.validate()) {
            //   UserDatabase.addWorkingDetails(data: {
            //     "type": "std",
            //     "institute": _instController.text,
            //     "adress": _stdAddressController.text,
            //     "degree": _degreeController.text,
            //   });
            //   _clearControlers();
            // } else if (isEmployee && _empformKey.currentState!.validate()) {
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
            // if (_image == null) {
            //   setState(() {
            //     showImgError = true;
            //   });
            // }
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
