import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/models/ShippingInfo.dart';
import 'package:project1/screens/addcard.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/order_review.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/UserPreferences.dart';
import 'package:http/http.dart' as http;

class PaymentInformationPage extends StatefulWidget {
  final ShippingInfo shipping;
  final List<CartItem> cartItems;
  const PaymentInformationPage({
    super.key,
    required this.shipping,
    required this.cartItems,
  });
  @override
  State<PaymentInformationPage> createState() => _PaymentInformationPageState();
}

class _PaymentInformationPageState extends State<PaymentInformationPage> {
  // ShippingInfo shipping1 = this.shipping;
  List paymentArr = [
    {"name": "Cash on delivery", "icon": "images/cash.jpeg"},
    {"name": "** ** ** 2187", "icon": "images/visa.jpeg"},
    //{"name": "test@gmail.com", "icon": "images/paypal.jpeg"},
  ];

  int selectMethod = -1;
  bool showAddCardView = false; // Boolean to control visibility
  bool paymentMethod = false;
  final _formKey = GlobalKey<FormState>();
  int method = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '    Payment Information',
          style: TextStyle(
            fontSize: 25,
            color: kourcolor1,
          ),
        ),
      ),
      body: Column(
        children: [
          /*  SizedBox(
            height: 50,
          ), */
          Container(
            decoration: BoxDecoration(color: kourcolor1),
            height: 8,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment method",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: paymentArr.length,
                  itemBuilder: (context, index) {
                    var pObj = paymentArr[index] as Map? ?? {};
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2))),
                      child: Row(
                        children: [
                          Image.asset(pObj["icon"].toString(),
                              width: 50, height: 20, fit: BoxFit.contain),
                          Expanded(
                            child: Text(
                              pObj["name"],
                              style: TextStyle(
                                  color: kourcolor1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectMethod = index;
                                // Show AddCardView if Visa is selected
                                showAddCardView =
                                    pObj["name"] == "** ** ** 2187";
                                paymentMethod = true;
                                // method = 2;

                                print(paymentMethod);
                              });
                            },
                            child: Icon(
                              selectMethod == index
                                  ? Icons.radio_button_on
                                  : Icons.radio_button_off,
                              color: kourcolor1,
                              size: 15,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(color: kourcolor1),
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Visibility(
                      visible: showAddCardView,
                      child: AddCardView(),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          orderStoring(
                              userId: UserPreferences.getUserID(),
                              shippingAddress: widget.shipping.address +
                                  ' , ' +
                                  widget.shipping.city +
                                  ' , ' +
                                  widget.shipping.state,
                              paymentMethod: "cash",
                              items: widget.cartItems);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderReviewPage(
                                  shipping: widget.shipping,
                                ),
                              ));
                        }
                      },
                      child: Text(
                        'Review Order',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            kourcolor1, // Change this to your desired color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> orderStoring({
    required String? userId,
    required String shippingAddress,
    required String paymentMethod,
    required List<CartItem> items,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final List<Map<String, dynamic>> itemsJson = items.map((item) => item.toJson()).toList();

    print("Items JSON: ${itemsJson.toString()}"); // Updated for clearer logging

    final int totalAmount = items.fold(0, (sum, current) => sum + current.price * current.quantity);
    print("Total Amount: $totalAmount"); // Updated for clearer logging

    final response = await http.post(
      Uri.parse('http://$ipAddress:5000/orderStoring'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'shipping_address': shippingAddress,
        'payment_method': paymentMethod,
        'items': itemsJson,
        'total_amount': totalAmount,
        'order_status': 'Processing',
      }),
    );

    print("HTTP Response: $response");

    if (response.statusCode == 200 || response.statusCode == 201) {
        print('Order created successfully!');
        print('Received response body: ${response.body}');
        if (response.headers['content-type']?.contains('application/json') ?? false) {
          try {
            final responseData = json.decode(response.body);
            print('Response Data: $responseData');
          } catch (e) {
            print('Error parsing response: $e');
          }
        } else {
          print('Received non-JSON response');
        }
    } else {
        print('Failed to create order. Status code: ${response.statusCode}');
        throw Exception('Failed to create order. Status code: ${response.statusCode}');
    }
}

}
