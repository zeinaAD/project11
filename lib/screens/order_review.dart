import 'package:flutter/material.dart';
import 'package:project1/screens/checkout_message_view.dart';
import 'package:project1/utilities/constants.dart';

class OrderReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '           Order Review',
        style: TextStyle(
          fontSize: 25,
          // fontWeight: FontWeight.bold,
          color: kourcolor1,
        ),
      )),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Display of shipping address, payment method, and order summary
          ListTile(
            title: Text('Shipping Address'),
            subtitle: Text('123 Main St, City, State, 12345'),
          ),
          ListTile(
            title: Text('Payment Method'),
            subtitle: Text('Visa ** ** ** 1234'),
          ),
          ListTile(
            title: Text('Order Number'),
            subtitle: Text('123456'),
          ),
          ListTile(
            title: Text('Order Summary'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item 1: \$100.00'),
                Text('Item 2: \$200.00'),
                SizedBox(height: 10),
                Text('Total: \$300.00',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            title: Text('Estimated Delivery Date'),
            subtitle: Text('3-5 business days'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
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
                  minChildSize: 0.4, // Minimum height of 40% of screen height
                  maxChildSize: 0.9, // Maximum height of 90% of screen height
                  expand: false,
                  builder: (context, scrollController) => SingleChildScrollView(
                    controller: scrollController,
                    child: CheckoutMessageView(),
                  ),
                ),
              );
            },
            child: Text(
              'Place Order',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: kourcolor1, // Change this to your desired color
            ),
          ),
        ],
      ),
    );
  }
}
