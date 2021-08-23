import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetLicense extends StatelessWidget {
  final bool isreadonly;
  final TextEditingController _licenseController = TextEditingController();

  final TextEditingController _vehicleController = TextEditingController();

  GetLicense({required this.isreadonly});

  @override
  Widget build(BuildContext context) {
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
                color: Colors.red,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height -
                MediaQuery.of(context).padding.top -
                AppBar().preferredSize.height,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 15),
                DropdownSearch<String>(
                  // .collapsed(hintText: "Province",border: Border.),
                  mode: Mode.MENU,
                  showSearchBox: true,
                  showSelectedItem: true,
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
                  label: "Area",
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: print,
                  // selectedItem: "Punjab",
                ),
                SizedBox(height: 25),
                TextFormField(
                  readOnly: isreadonly,
                  controller: _licenseController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: 'Enter Your License number',
                    hintStyle: TextStyle(fontSize: 16),
                    labelText: "License",
                    // labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                        width: 0.5,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  ),
                  // textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '???';
                    }
                    //there must be space so it allow spaces
                    if (!RegExp(r'^[0-9 ]+$').hasMatch(value)) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
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
                                    genderBottomSheetItem(
                                        Icons.motorcycle, Colors.blue, "Bike"),
                                    genderBottomSheetItem(
                                        Icons.time_to_leave_rounded,
                                        Colors.green,
                                        "Car"),
                                    genderBottomSheetItem(Icons.all_inclusive,
                                        Colors.red, "Both"),
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
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        // hintText: 'Choose your Vehicles',
                        // hintStyle: TextStyle(fontSize: 16),
                        labelText: "Authorized Vehicle",
                        // labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            width: 0.5,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      ),
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
                SizedBox(height: 20),
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // color: Colors.deepPurple,
                          child: Center(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 70,
                                width: 130,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 70,
                                      child: Text(
                                        "Front Side of License",
                                        maxLines: 2,
                                      ),
                                    ),
                                    Icon(
                                      Icons.camera_enhance,
                                      size: 35,
                                      color: Colors.pink,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 0.3,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Container(
                          // color: Colors.yellow,
                          child: Center(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 70,
                                width: 130,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 70,
                                      child: Text(
                                        "Back Side of License",
                                        maxLines: 2,
                                      ),
                                    ),
                                    Icon(
                                      Icons.camera_enhance,
                                      size: 35,
                                      color: Colors.pink,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  onPressed: () {},
                  child: CustomText(
                    text: "Submit Details",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell genderBottomSheetItem(IconData icon, Color col, String title) {
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
}
