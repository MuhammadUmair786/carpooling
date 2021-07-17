import 'dart:io';

import 'package:carpooling_app/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddVehicle extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    File? _image;
    final picker = ImagePicker();

    // Future getImage() async {
    //   final pickedFile = await picker.getImage(source: ImageSource.camera);

    //   setState(() {
    //     if (pickedFile != null) {
    //       _image = File(pickedFile.path);
    //       // pickedFile.path.
    //     } else {
    //       print('No image selected.');
    //     }
    //   });
    // }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(right: 10),
                    //   child: Icon(
                    //     Icons.car,
                    //     size: 30,
                    //   ),
                    // ),
                    Expanded(
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItem: true,
                        items: ["Car", "Motercycle"],
                        label: "Vehicle Type",
                        hint: "Choose your Vehicle Type",
                        maxHeight: 120,
                        // popupItemDisabled: (String s) => s.startsWith('I'),
                        // onChanged: print,
                        selectedItem: "Car",
                        // dropdownSearchDecoration: InputDecoration(
                        // icon: Icon(
                        //   Icons.motorcycle_sharp,
                        //   color: Colors.amber,
                        //   size: 30,
                        // ),
                        // labelStyle: TextStyle(fontSize: 20),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(),
                        //   borderRadius:
                        //       const BorderRadius.all(Radius.circular(14.0)),
                        // ),
                        // ),
                      ),
                    ),
                  ],
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          height: deviceWidth / 1.75,
                          color: Colors.grey[300],
                          child: _image == null
                              ? Center(child: Text('No image selected.'))
                              : Image.file(_image!, fit: BoxFit.fill),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                              onPressed: () async {
                                final pickedFile = await picker.getImage(
                                    source: ImageSource.gallery);

                                setState(() {
                                  if (pickedFile != null) {
                                    _image = File(pickedFile.path);
                                    // pickedFile.path.
                                  } else {
                                    print('No image selected.');
                                  }
                                });
                              },
                              child: Text("Upload Photo")),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Vehicle Name',
                      hintText: "Honda Civic 2018 or Honda-125 2020"),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Vehicle Color',
                      hintText: "Red"),
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'City Code',
                            hintText: "RIW"),
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.name,

                        // inputFormatters: [FilteringTextInputFormatter.],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.length > 3) {
                            return 'Please enter a City Code';
                          }
                          if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return 'Enter valid Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number',
                            hintText: "2981"),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter only numeric Values';
                          }
                          if (!RegExp(r'^[0-9 ]+$').hasMatch(value)) {
                            return 'Enter valid Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mileage',
                      hintText: "20 km/liter"),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Must fill this Feild';
                    }
                    if (value.length > 2) {
                      return 'Please enter a valid milage Value';
                    }
                    return null;
                  },
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Vehicle Added Sucessfully',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Add Vehicle"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selected: 3,
      ),
    );
  }
}
//car name
//model
//color
//average milage
//
