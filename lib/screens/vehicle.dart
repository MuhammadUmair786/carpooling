import 'package:carpooling_app/screens/add_vehicle.dart';
import 'package:carpooling_app/widgets/bottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              VehicleItem(),
              VehicleItem(),
              VehicleItem(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVehicle()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(
        selected: 3,
      ),
    );
  }
}

class VehicleItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: 0.25,
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                      border: Border.all(color: Colors.white10),
                      borderRadius: BorderRadius.circular(20)),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1612997951749-ae9c3fffaef3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                    fit: BoxFit.fill,

                    // width: 68,
                    // height: 68,
                    // repeat: ImageRepeat.repeat,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Corolla 2016",
                      textScaleFactor: 1.4,
                    ),
                    Text(
                      "RIW-2981",
                      textScaleFactor: 1.4,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "21",
                    textScaleFactor: 1.5,
                  ),
                  Text("KM/L"),
                ],
              ),
            )
          ],
        ),
      ),
      secondaryActions: <Widget>[
        //from right side
        new IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          // onTap: () => _showSnackBar('More'),
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          // onTap: () => _showSnackBar('Delete'),
        ),
      ],
    );
  }
}
