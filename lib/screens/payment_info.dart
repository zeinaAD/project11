import 'package:flutter/material.dart';
import 'package:project1/screens/addcard.dart';
import 'package:project1/screens/order_review.dart';
import 'package:project1/utilities/constants.dart';

class PaymentInformationPage extends StatefulWidget {
  @override
  State<PaymentInformationPage> createState() => _PaymentInformationPageState();
}

class _PaymentInformationPageState extends State<PaymentInformationPage> {
  List paymentArr = [
    {"name": "Cash on delivery", "icon": "images/cash.jpeg"},
    {"name": "** ** ** 2187", "icon": "images/visa.jpeg"},
    {"name": "test@gmail.com", "icon": "images/paypal.jpeg"},
  ];

  int selectMethod = -1;
  bool showAddCardView = false; // Boolean to control visibility
  final _formKey = GlobalKey<FormState>();

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
                    /* TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 0.65, // 80% of screen height
                            minChildSize:
                                0.4, // Minimum height of 40% of screen height
                            maxChildSize:
                                0.9, // Maximum height of 90% of screen height
                            expand: false,
                            builder: (context, scrollController) =>
                                SingleChildScrollView(
                              controller: scrollController,
                              child: AddCardView(),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.add, color: kourcolor1),
                      label: Text(
                        "Add Card",
                        style: TextStyle(
                            color: kourcolor1,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                    ) */
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderReviewPage()),
                          );
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
}
