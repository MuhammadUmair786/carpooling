import 'package:carpooling_app/controllers/bottomNavBarController.dart';
import 'package:carpooling_app/views/vehicle/addvehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/get_core.dart';

class Vehicle extends StatelessWidget {
  final vehicleList = Get.find<BottomNavBarController>().getUser!.vehicleList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4793E),
        elevation: 0,
        title: Text("Vehicles"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (vehicleList.isEmpty)
                Center(
                  child: CustomText(
                    text: "No Vehicles Found",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: vehicleList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return vehicleItem(
                      vehicleList[index]['model'] +
                          " " +
                          vehicleList[index]['year'],
                      vehicleList[index]['noAlp'] +
                          "-" +
                          vehicleList[index]['noNum'],
                      double.parse(vehicleList[index]['milage'].toString()),
                      vehicleList[index]['img_url'],
                    );
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF4793E),
        onPressed: () {
          Get.to(() => AddVehicle());
          // print(vehicleList);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Container vehicleItem(
      String name, String number, double milage, String imgUrl) {
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
                radius: 30,
                backgroundImage: NetworkImage(imgUrl
                    // "https://images.unsplash.com/photo-1612997951749-ae9c3fffaef3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                    ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    text: number,
                    size: 12,
                  ),
                  SizedBox(height: 5),
                  CustomText(
                    text: "$milage KM/L",
                    color: Colors.orange,
                    size: 12,
                    weight: FontWeight.bold,
                  )
                ],
              ),
            ],
          ),
          // IconButton(
          //   onPressed:(){
          //     UserData
          //   },

          //  icon: Icon(Icons.delete),
          //   // size: 25,
          // )
        ],
      ),
    );
  }
}
