import 'package:carpooling_app/widgets/bottomNavBar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CreateRide2 extends StatefulWidget {
  @override
  _CreateRide2State createState() => _CreateRide2State();
}

class _CreateRide2State extends State<CreateRide2> {
  bool isShowCostEstimation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItem: true,
                items: ["Honda Civic RIW-2981", "Honda-125 SDF-6547"],
                label: "Choose Vehicle",
                hint: "Choose your Vehicle",
                maxHeight: 120,
                // popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (String? item) {
                  print(item);
                  setState(() {
                    isShowCostEstimation = true;
                  });
                },
                // selectedItem: "Honda Civic RIW-2981",
                // dropdownSearchDecoration: InputDecoration(
                //   border: UnderlineInputBorder(
                //     borderSide: const BorderSide(width: 5),
                //   ),
                // OutlineInputBorder(
                //   borderSide: BorderSide(),
                //   borderRadius:
                //       const BorderRadius.all(Radius.circular(14.0)),
                // ),
                // ),
              ),
            ),
            if (isShowCostEstimation)
              Container(
                child: Column(
                  children: [
                    Text(
                      "Total Cost: RS 200",
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Cost per passanger: 70",
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Ride Posted Sucessfully',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                      child: Text("Publish Ride"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selected: 2,
      ),
    );
  }
}
