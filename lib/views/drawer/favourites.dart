import 'package:carpooling_app/views/viewProfile.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4793E),
        elevation: 0,
        title: Text("Favourite"),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                favouriteItem(),
                favouriteItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container favouriteItem() {
    return Container(
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  // Get.to(() => ViewProfile());
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: Get.width / 1.85,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text: "Uzair Iqbal",
                        size: 18,
                      ),
                    ),
                  ),
                  GFRating(
                    color: GFColors.SUCCESS,
                    borderColor: GFColors.SUCCESS,
                    filledIcon: Icon(Icons.star, color: Color(0xFFF4793E)),
                    defaultIcon: Icon(
                      Icons.star,
                      color: GFColors.LIGHT,
                    ),
                    size: GFSize.SMALL,
                    value: 3.5,
                    onChanged: (value) {},
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.notifications_active,size:18),
                  SizedBox(height: 5),
                  Icon(Icons.favorite,size:18)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget startEndItem(IconData ic, String locationName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(ic,color:Color(0xFFF4793E)),
        SizedBox(width: 5),
        Container(
          alignment: Alignment.topLeft,
          width: Get.width / 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              text: locationName,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
