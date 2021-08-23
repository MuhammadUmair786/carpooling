import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dropdown_search/dropdown_search.dart';

class AddVehicle extends StatelessWidget {
  @override
  // int _value = 1;
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          child: ListView(children: [
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<String>(
                        searchBoxDecoration:
                            InputDecoration.collapsed(hintText: "Vehicle Type"),
                        // showSearchBox: true,
                        mode: Mode.MENU,
                        showSelectedItem: true,
                        items: ["Car", "MotorCycle"],
                        label: "Vehicle Type",
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: print,
                        selectedItem: "Car"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<String>(
                        searchBoxDecoration:
                            InputDecoration.collapsed(hintText: "Company"),
                        // showSearchBox: true,
                        mode: Mode.MENU,
                        showSelectedItem: true,
                        items: ["Honda", "Suzuki", "toyotta", 'mercendese'],
                        label: "Company",
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: print,
                        selectedItem: "honda"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          items: ["2000", "2001", "2002", '2003'],
                          label: "Model",
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: print,
                          selectedItem: "2000")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItem: true,
                        items: ["blue", "white", "black", 'yellow'],
                        label: "Color",
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: print,
                        selectedItem: "black"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<String>(
                        searchBoxDecoration:
                            InputDecoration.collapsed(hintText: "Engine Type"),
                        mode: Mode.MENU,
                        showSelectedItem: true,
                        items: ["800 cc", "1000 cc", "1300 cc"],
                        label: "Engine",
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: print,
                        selectedItem: "800 cc"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          items: ["Hybrid", "Non-Hybrid"],
                          label: "Engine Type",
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: print,
                          selectedItem: "Non-Hybrid")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        previousValue: "",
                        label: "Alphabets",
                        placeholder: "RIW"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                        previousValue: "",
                        label: "Number",
                        placeholder: "2125"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomTextField(
                  previousValue: "", label: "Millage", placeholder: "10km/h"),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 35),
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: CustomText(
                  text: "Add Vehicle",
                  size: 17,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        )
      ])),
    ));
  }
}
