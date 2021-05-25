import 'package:flutter/material.dart';

class SearchRide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 23),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.trip_origin,
                          size: 22,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Choose starting point'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Choose Destination'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Icon(Icons.my_location_sharp),
                  //         Text("Your Location"),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         Icon(Icons.location_on_outlined),
                  //         Text("Choose on Map"),
                  //       ],
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
            Text("Below there is map ....")
          ],
        ),
      ),
    );
  }
}
