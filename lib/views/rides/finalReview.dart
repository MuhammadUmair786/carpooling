import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpooling_app/constants/secrets.dart';
import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/models/UserModel.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';

import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';

class FinalReview extends StatelessWidget {
  final UserModel user;
  final String rideId;

  FinalReview({Key? key, required this.user, required this.rideId})
      : super(key: key);
  var _commentCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double ratingValue = 0;

    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: user.img ?? Secrets.NO_IMG,
                // fit: BoxFit.cover,
                // repeat: ImageR,
                imageBuilder: (context, imageProvider) => Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  strokeWidth: 2,
                ),
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(height: 10),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: CustomText(
                    text: user.name,
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
              StatefulBuilder(builder: (context, innerState) {
                return GFRating(
                  color: GFColors.SUCCESS,
                  borderColor: GFColors.SUCCESS,
                  filledIcon: Icon(Icons.star, color: GFColors.SUCCESS),
                  defaultIcon: Icon(
                    Icons.star,
                    color: GFColors.LIGHT,
                  ),
                  size: GFSize.LARGE,
                  value: ratingValue,
                  onChanged: (value) {
                    innerState(() {
                      ratingValue = value;
                    });
                  },
                );
              }),
              SizedBox(height: 10),
              TextFormField(
                maxLines: null,
                maxLength: 50,
                controller: _commentCont,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your comments here'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(80, 40),
                  primary: Color(0xFFF4793E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (ratingValue == 0) {
                    UserDatabase.addReviews(
                        ratingValue, _commentCont.text, rideId);
                  } else {
                    showSnackBar("Please Rate your Driver", "");
                  }
                },
                child: CustomText(
                    text: "Send Reviews", size: 20, color: Colors.white
                    // weight: FontWeight.bold,

                    ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
