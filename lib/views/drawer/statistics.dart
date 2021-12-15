import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4793E),
        title: Text(
          "Statistics",
          
        ),
        elevation: 1,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFF4793E),width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.ac_unit_sharp,color: Color(0xFFF4793E),),
                      CustomText(
                        text: "Monthly Overview",
                        size: 18,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  GridView.count(
                    shrinkWrap: true,
                    // primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 3.2,
                    children: <Widget>[
                      statsItems("Earned", "Rs. 230"),
                      statsItems("Spent", "Rs. 120"),
                      statsItems("Total Rides", "5"),
                      statsItems("Active Rides", "1"),
                    ],
                  ),
                  Container(
                    height: 0.5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    color: Colors.grey,
                  ),
                  CustomText(
                      text: "Pending Clearence",
                      size: 14,
                      weight: FontWeight.w500),
                  CustomText(
                      text: "Rs. 400", size: 25, weight: FontWeight.bold),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //percent value must be between 0.0 - 1.0
                  percentageCircles(0.8, "Positive", "Rating"),
                  percentageCircles(0.85, "Ride", "Completion"),
                  percentageCircles(0.85, "Profile", "Completion"),
                  percentageCircles(0.65, "Response", "Time"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget percentageCircles(double percentage, String txt1, String txt2) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 54.0,
          lineWidth: 4.0,
          animation: true,
          animationDuration: 800,
          percent: percentage,
          center: Text(
            // percent.toString() + "%",
            "${(percentage * 100).toInt()}%",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          // backgroundColor: Colors.grey[300]!,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Color(0xFFF4793E),
        ),
        CustomText(
          text: txt1,
          size: 15,
        ),
        CustomText(
          text: txt2,
          size: 15,
        ),
      ],
    );
  }

  Widget statsItems(String heading, String value) {
    return Container(
      // color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: heading,
            size: 14,
          ),
          CustomText(
            text: value,
            size: 25,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
