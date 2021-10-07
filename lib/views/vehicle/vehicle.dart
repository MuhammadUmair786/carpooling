import 'package:carpooling_app/views/vehicle/addvehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/get_core.dart';

class Vehicle extends StatelessWidget {
  var vehicleList = [
    {
      "type": "car",
      "name": "Corola",
      "color": "red",
      "number": "RIW-2981",
      "image": "img-link"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Vehicles"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 30),
              vehicleItem(),
              vehicleItem(),
              vehicleItem(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddVehicle());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Container vehicleItem() {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1612997951749-ae9c3fffaef3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Corolla 2016",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    text: "RIW-2981",
                    size: 20,
                  ),
                  SizedBox(height: 5),
                  CustomText(
                    text: "21 KM/L",
                    color: Colors.orange,
                    size: 20,
                    weight: FontWeight.bold,
                  )
                ],
              ),
            ],
          ),
          Icon(
            Icons.delete,
            size: 25,
          )
        ],
      ),
    );
  }
}
