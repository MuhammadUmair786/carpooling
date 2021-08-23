import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appearence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: Get.width / 1.75,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://www.techwalls.com/wp-content/uploads/2012/04/color-scheme-blog.jpg"),
                          fit: BoxFit.cover)),
                ),
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
            colorschemeitem(
              "Dark Theme", Colors.brown, Colors.cyan,
              Colors.deepOrange, Colors.green,
              ThemeData.dark(),
              // MyThemes.darkTheme,
            ),
            colorschemeitem(
              "Light Theme",
              Colors.deepOrange,
              Colors.brown,
              Colors.red,
              Colors.purple,
              MyThemes.lightTheme,
            ),
            // colorschemeitem(
            //   "High Contrast Theme",
            //   Colors.teal,
            //   Colors.green,
            //   Colors.yellow,
            //   Colors.deepOrange,
            //   ThemeData.light(),
            // ),
          ],
        ),
      ),
    ));
  }

  Widget colorschemeitem(
      String title, Color c1, Color c2, Color c3, Color c4, ThemeData theme) {
    return InkWell(
      onTap: () {
        Get.changeTheme(theme);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                size: 20,
                weight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 30,
                    height: 30,
                    color: c1,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 30,
                    height: 30,
                    color: c2,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 30,
                    height: 30,
                    color: c3,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 30,
                    height: 30,
                    color: c4,
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
