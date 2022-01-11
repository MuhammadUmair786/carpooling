import 'dart:convert';

import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // makePayment();
      appBar: AppBar(
          title: Text('Payment'),
          elevation: 0,
          backgroundColor: Color(0xFFF4793E)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addCashItem(Icons.account_balance, "Through Bank", () {
                  // Get.to(() =>
                  makePayment();
                }),
                addCashItem(Icons.e_mobiledata, "Through EasyPaisa", () {
                  // Get.to(() => NotificationSetting());
                }),
                addCashItem(Icons.format_align_justify, "Through JazzCash", () {
                  // Get.to(() => Privacy());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell addCashItem(IconData icon, String title, Function() fun) {
    return InkWell(
      onTap: fun,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Material(
          // padding: EdgeInsets.symmetric(horizontal: 15),
          color: Color(0xFFF4793E),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(width: 15),
                CustomText(
                  text: title,
                  weight: FontWeight.w400,
                  size: 16,
                  color: Colors.white,
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'Carpooling'))
          .then((value) {
        displayPaymentSheet();
      });

      ///now finally display payment sheeet
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;

        UserDatabase.updateBalance(20 * 100);
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51K6YojDPueSKLP7wZMABZUgxTTo6s8wyZmaJt2IWj6olQi6IAS07diHE2fEPu57RyUlsIlFbIaFFfZ4SsCOBwXVR00hiX6sRR9',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
