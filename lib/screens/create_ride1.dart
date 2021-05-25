// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CreateRide1 extends StatelessWidget {
  // GlobalKey _formkey = GlobalKey();
  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // DateTime selectedDate = DateTime.now();

  String? dateText = "Select Date";

  String? timeText = "Select Time";

  bool? isSwitched = false;

  String? _radioGroupValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 130),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    padding: EdgeInsets.all(12),
                    width: double.maxFinite,
                    child: Text(
                      "Choose Starting Point",
                      textScaleFactor: 1.4,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      icon: Icon(
                        Icons.trip_origin,
                        size: 30,
                      ),
                      onPressed: () {
                        print("open map screen");
                      }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    padding: EdgeInsets.all(12),
                    width: double.maxFinite,
                    child: Text(
                      "Choose Destination Point",
                      textScaleFactor: 1.4,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      icon: Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                      onPressed: () {
                        print("open map screen");
                      }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    padding: EdgeInsets.all(12),
                    width: double.maxFinite,
                    child: Text(
                      "Select Route",
                      textScaleFactor: 1.4,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      icon: Icon(
                        Icons.map_sharp,
                        size: 30,
                      ),
                      onPressed: () {
                        print("open map screen");
                      }),
                ),
              ],
            ),
            // Column(children: [
            //   Text("Select Vehicle"),
            //   Container(child: Column(
            //     children: [
            //       //image
            //       Container(width: 30,height: 30,)
            //     ],
            //   )
            //   ,)
            // ],),
            Text("Select Vehcle...pending"),

            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5),
                        ),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                      padding: EdgeInsets.all(12),
                      width: double.maxFinite,
                      child: Text(
                        dateText!,
                        textScaleFactor: 1.4,
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
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 10)),
                          ));

                          if (picked != null)
                            setState(() {
                              dateText = Jiffy(
                                      [picked.year, picked.minute, picked.day])
                                  .yMMMMEEEEd;
                            });
                        } catch (ex) {
                          print(ex);
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5),
                        ),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                      padding: EdgeInsets.all(12),
                      width: double.maxFinite,
                      child: Text(
                        timeText!,
                        textScaleFactor: 1.4,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      icon: Icon(
                        Icons.access_time,
                        size: 30,
                      ),
                      onPressed: () async {
                        try {
                          final TimeOfDay? picked = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ));
                          if (picked != null)
                            setState(() {
                              timeText = picked.format(context);
                            });
                        } catch (ex) {
                          print(ex);
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1.5),
                              ),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 15),
                            padding: EdgeInsets.all(12),
                            // width: double.maxFinite,
                            child: Text(
                              "Gender Prefrence",
                              textScaleFactor: 1.4,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Switch(
                            value: isSwitched!,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                // print(isSwitched);
                              });
                            },
                            activeTrackColor: Colors.yellow,
                            activeColor: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                    if (isSwitched!)
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                                value: "Male",
                                groupValue: _radioGroupValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    _radioGroupValue = value;
                                  });
                                }),
                            const Text('Male'),
                            SizedBox(width: 10),
                            Radio(
                                value: "FeMale",
                                groupValue: _radioGroupValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    _radioGroupValue = value;
                                  });
                                }),
                            const Text('FeMale'),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Save and Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
