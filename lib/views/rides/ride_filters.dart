import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color selectedColor = Colors.blue;

class RideFilter extends StatelessWidget {
  final TextEditingController _genderController =
      TextEditingController(text: "None");
  final TextEditingController _vehicleController =
      TextEditingController(text: "Both");
  final TextEditingController _seatsController =
      TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0.5,
        leading: Icon(
          Icons.filter_list_alt,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 45,
        title: Text("Filters"),
        actions: [
          IconButton(
            splashRadius: 25,
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height -
              MediaQuery.of(context).padding.top -
              AppBar().preferredSize.height,
          child: Column(
            children: [
              filterItems(
                "Gender Preference",
                GenderItem(
                  controller: _genderController,
                ),
              ),
              filterItems(
                "Vehicle",
                VehicleItem(
                  controller: _vehicleController,
                ),
              ),
              // filterItems(
              //   "Available Seats",
              //   AvailableSeats(
              //     controller: _seatsController,
              //   ),
              // ),
              Spacer(),
              Container(
                //same as top containers
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // minimumSize: Size(double.infinity, 35),
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: CustomText(
                          text: "Clear",
                          size: 17,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: Get.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // minimumSize: Size(double.infinity, 35),
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          print("gender= " + _genderController.text);
                          print("vehicle= " + _vehicleController.text);
                          print("seats= " + _seatsController.text);
                        },
                        child: CustomText(
                          text: "Apply",
                          size: 17,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Container filterItems(String title, Widget childWidget) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.3),
        ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            weight: FontWeight.bold,
            size: 25,
          ),
          SizedBox(height: 10),
          childWidget,
        ],
      ),
    );
  }
}

class AvailableSeats extends StatefulWidget {
  final TextEditingController controller;

  const AvailableSeats({required this.controller});
  @override
  _AvailableSeatsState createState() => _AvailableSeatsState();
}

class _AvailableSeatsState extends State<AvailableSeats> {
  List<bool> isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderColor: selectedColor,
      fillColor: selectedColor.withOpacity(0.3),
      borderWidth: 2,
      selectedBorderColor: selectedColor,
      borderRadius: BorderRadius.circular(10),
      // renderBorder: false,
      children: <Widget>[
        availableSeatsItem("1"),
        availableSeatsItem("2"),
        availableSeatsItem("3")
      ],
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
          widget.controller.text = (index + 1).toString();
        });
      },
      isSelected: isSelected,
    );
  }

  Container availableSeatsItem(String value) {
    return Container(
      alignment: Alignment.center,
      child: CustomText(
        text: value,
        size: 28,
        color: Colors.blue,
        weight: FontWeight.bold,
      ),
    );
  }
}

class GenderItem extends StatefulWidget {
  final TextEditingController controller;

  const GenderItem({required this.controller});
  @override
  _GenderItemState createState() => _GenderItemState();
}

class _GenderItemState extends State<GenderItem> {
  List<bool> isSelected = [false, false, true];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderColor: selectedColor,
      fillColor: selectedColor.withOpacity(0.3),
      borderWidth: 2,
      selectedBorderColor: selectedColor,
      borderRadius: BorderRadius.circular(10),
      // renderBorder: false,
      children: <Widget>[
        genderItem(Icons.male, Colors.orange, "Male"),
        genderItem(Icons.female, Colors.green, "Female"),
        genderItem(Icons.all_inclusive, Colors.red, " Both "),
      ],
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
          if (index == 0) {
            widget.controller.text = "Male";
          } else if (index == 1) {
            widget.controller.text = "Female";
          } else {
            widget.controller.text = "None";
          }
        });
      },
      isSelected: isSelected,
    );
  }

  Container genderItem(IconData icon, Color col, String title) {
    return Container(
      height: 60,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: col,
            size: 30,
          ),
          CustomText(
            text: title,
            color: col,
            size: 18,
          )
        ],
      ),
    );
  }
}

class VehicleItem extends StatefulWidget {
  final TextEditingController controller;

  const VehicleItem({required this.controller});
  @override
  _VehicleItemState createState() => _VehicleItemState();
}

class _VehicleItemState extends State<VehicleItem> {
  List<bool> isSelected = [false, false, true];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderColor: selectedColor,
      fillColor: selectedColor.withOpacity(0.3),
      borderWidth: 2,
      selectedBorderColor: selectedColor,
      borderRadius: BorderRadius.circular(10),
      // renderBorder: false,
      children: <Widget>[
        vehicleItem(Icons.motorcycle, Colors.blue, "Bike"),
        vehicleItem(Icons.time_to_leave_rounded, Colors.green, "Car"),
        vehicleItem(Icons.all_inclusive, Colors.red, "Both"),
      ],
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
          if (index == 0) {
            widget.controller.text = "Bike";
          } else if (index == 1) {
            widget.controller.text = "Car";
          } else {
            widget.controller.text = "Both";
          }
        });
      },
      isSelected: isSelected,
    );
  }

  Container vehicleItem(IconData icon, Color col, String title) {
    return Container(
      height: 60,
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: col,
            size: 30,
          ),
          CustomText(
            text: title,
            color: col,
            size: 18,
          )
        ],
      ),
    );
  }
}
