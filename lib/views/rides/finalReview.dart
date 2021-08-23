import 'package:carpooling_app/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';

class FinalReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80 "),
                  radius: 60.0,
                ),
                SizedBox(height: 10),
                FittedBox(
                    fit: BoxFit.fitWidth,
                    child: CustomText(
                      text: "Uzair Iqbal",
                      size: 30,
                    )),
                SizedBox(height: 20),
                CustomText(
                  text: "Rate your driver",
                  size: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                GFRating(
                  color: GFColors.SUCCESS,
                  borderColor: GFColors.SUCCESS,
                  filledIcon: Icon(Icons.star, color: GFColors.SUCCESS),
                  defaultIcon: Icon(
                    Icons.star,
                    color: GFColors.LIGHT,
                  ),
                  size: GFSize.LARGE,
                  value: 3.5,
                  onChanged: (value) {},
                ),
                SizedBox(height: 10),
                TextField(
                  maxLines: null,
                  maxLength: 50,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write your comments here'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: CustomText(
                    text: "Send Reviews",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
