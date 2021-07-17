import 'package:carpooling_app/screens/home.dart';
import 'package:carpooling_app/screens/map.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';

class Profile extends StatelessWidget {
  bool isStudent = false;
  bool isEmployee = false;
  String? dateText = "Select Date of Birth";
  String houseAddress = "House Address";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                SizedBox(height: 100),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: "Enter your full name"),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    //there must be space so it allow spaces
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            width: double.maxFinite,
                            child: Text(
                              dateText!,
                              textScaleFactor: 1.2,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            icon: Icon(
                              Icons.date_range_outlined,
                              size: 30,
                            ),
                            onPressed: () async {
                              // print("rebuild here");
                              try {
                                final DateTime? picked = (await showDatePicker(
                                  currentDate: DateTime.now(),
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                ));

                                if (picked != null)
                                  setState(() {
                                    dateText = Jiffy([
                                      picked.year,
                                      picked.minute,
                                      picked.day
                                    ]).yMMMMd;
                                  });
                              } catch (ex) {
                                print(ex);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 15),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          items: ["Student", "Employee"],
                          label: "Status",
                          hint: "Choose your Status",
                          maxHeight: 120,
                          onChanged: (selected) {
                            if (selected == "Student") {
                              setState(() {
                                isStudent = true;
                                isEmployee = false;
                              });
                            }
                            if (selected == "Employee") {
                              setState(() {
                                isEmployee = true;
                                isStudent = false;
                              });
                            }
                          },
                          // popupItemDisabled: (String s) => s.startsWith('I'),
                          // onChanged: print,
                          // selectedItem: "Employee",
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
                        SizedBox(height: 15),
                        if (isStudent)
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Institute',
                                      hintText:
                                          "Enter your School/College/University name"),
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    //there must be space so it allow spaces
                                    if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                        .hasMatch(value)) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Institute Address',
                                      hintText: "Enter your Institute Address"),
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    //there must be space so it allow spaces
                                    if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                        .hasMatch(value)) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Degree',
                                      hintText: "Enter your class/degree name"),
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    //there must be space so it allow spaces
                                    if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                        .hasMatch(value)) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        if (isEmployee)
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItem: true,
                                  items: [
                                    "Government",
                                    "Private",
                                    "Self-Business"
                                  ],
                                  label: "Job Nature",
                                  hint: "Choose the nature of your job",
                                  maxHeight: 180,
                                  // onChanged: (selected) {

                                  // },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Company',
                                      hintText:
                                          "Enter your Company/Office name"),
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    //there must be space so it allow spaces
                                    if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                        .hasMatch(value)) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Company Address',
                                      hintText: "Enter your Office Address"),
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    //there must be space so it allow spaces
                                    if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                        .hasMatch(value)) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Designation',
                                      hintText:
                                          "Designation i.e. Assistant Professor, Shift Incharge"),
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    //there must be space so it allow spaces
                                    if (!RegExp(r'^[a-zA-Z ]+$')
                                        .hasMatch(value)) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
                // SizedBox(height: 15),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              width: double.maxFinite,
                              child: Text(
                                houseAddress,
                                textScaleFactor: 1.2,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                              icon: Icon(
                                Icons.house_sharp,
                                size: 30,
                              ),
                              onPressed: () async {
                                LatLng result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => G_Map()),
                                );
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                        result.latitude, result.longitude);
                                setState(() {
                                  houseAddress =
                                      // "new value";
                                      placemarks[0].name.toString() +
                                          ", " +
                                          placemarks[0].locality.toString() +
                                          ", " +
                                          placemarks[0].country.toString();
                                });
                                // print(placemarks[0]);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        child: Text("Skip")),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Profile Saved Sucessfully',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        }
                      },
                      child: Text("Save"),
                    ),
                    SizedBox(width: 5),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//Name
//email 
//profession if student > enter instituion name, current class/semister
//if job > choose government or private
//address :- city , house address
//student : insitute, degree
//employee: company adress, government/private, designation, company email