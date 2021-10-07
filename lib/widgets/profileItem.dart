import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Function() func;

  const ProfileItem(
      {required this.title,
      required this.value,
      required this.icon,
      required this.func});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      // splashColor: Colors.yellow,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.blue,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      weight: FontWeight.bold,
                      size: 20,
                    ),
                    SizedBox(height: 3),
                    Container(
                      // width: Get.width / 2,
                      alignment: Alignment.topLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomText(
                          text: value,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )

          // ListTile(
          //   // onTap: func,
          //   dense: true,
          //   visualDensity: VisualDensity.comfortable,
          //   leading: Icon(
          //     icon,
          //     size: 30,
          //     color: Colors.white,
          //   ),
          //   title: CustomText(
          //     text: title,
          //     weight: FontWeight.bold,
          //     size: 20,
          //   ),
          //   subtitle: Container(
          //     // width: Get.width / 2,
          //     alignment: Alignment.topLeft,
          //     child: FittedBox(
          //       fit: BoxFit.scaleDown,
          //       child: CustomText(
          //         text: value ?? "",
          //         size: 20,
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );

    // InkWell(
    //   onTap: func,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border(
    //         bottom: BorderSide(width: 0.3),
    //       ),
    //     ),
    //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Icon(icon),
    //         SizedBox(width: 8),
    //         CustomText(
    //           text: title,
    //           weight: FontWeight.bold,
    //           size: 18,
    //         ),
    //         Spacer(),
    //         if (value.isNotEmpty)
    //           Container(
    //             width: Get.width / 2,
    //             alignment: Alignment.topRight,
    //             child: FittedBox(
    //               fit: BoxFit.scaleDown,
    //               child: CustomText(
    //                 text: value,
    //                 size: 20,
    //               ),
    //             ),
    //           )
    //       ],
    //     ),
    //   ),
    // );
  }
}
