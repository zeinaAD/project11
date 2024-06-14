import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/models/ShippingInfo.dart';
import 'package:project1/models/order.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/checkout_message_view.dart';
import 'package:project1/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project1/widgets/UserPreferences.dart';

class OrderReviewPage extends StatefulWidget {
  final ShippingInfo shipping;
  const OrderReviewPage({
    super.key,
    required this.shipping,
  });
  @override
  State<OrderReviewPage> createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  String orderStatus = "Processing";
  late Order order;
  late Future<Order> futureOrder;
  // futureOrder = fetchOrder("666570be2bfa942ff8aca91e");
  @override
  void initState() {
    super.initState();
    futureOrder = fetchOrder(
        UserPreferences.getUserID()); // Make sure to pass the correct ID
  }

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
      body: FutureBuilder<Order>(
        future: futureOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            // Use snapshot.data to access your order data
            Order order = snapshot.data!;
            return buildOrderDetails(order);
          } else {
            return Center(child: Text("No order found"));
          }
        },
      ),
    );
  }

  Widget buildOrderDetails(Order order) {
    List<Widget> itemWidgets = order.items.map((item) {
      // Log item details for debugging
      print(
          'Item Name: ${item.name.toString().replaceAll('\\n', '\n')}, Price: ${item.price}');
      // Create a text widget for each item
      return Text(
        '${item.name.toString().replaceAll('\\n', '\n') ?? "Unknown Item"}: \$${item.price?.toStringAsFixed(2) ?? "0.00"}',
        style: TextStyle(
            height: 1.5), // Increase line spacing for better readability
      );
    }).toList();

    // Add a SizedBox for spacing
    SizedBox(height: 10);
    // Add the total amount at the end of the list
    itemWidgets.add(Text(
      'Total: \$${order.totalAmount.toStringAsFixed(2)}', // Ensure the total amount is formatted to two decimal places
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16), // Make total amount bold and slightly larger
    ));

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ListTile(
          title: const Text('Shipping Address'),
          subtitle: Text(order.shippingAddress),
        ),
        ListTile(
          title: const Text('Payment Method'),
          subtitle: Text(order.paymentMethod),
        ),
        ListTile(
          title: const Text('Order Number'),
          subtitle: Text(order.orderNumber.toString()),
        ),
        ListTile(
          title: const Text('Order Status'),
          subtitle: Text(order.orderStatus),
        ),
        ListTile(
          title: const Text('Order Summary'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: itemWidgets,
          ),
        ),
        ListTile(
          title: const Text('Estimated Delivery Date'),
          subtitle: const Text('3-5 working days'),
        ),
        const SizedBox(height: 20),
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
          child:
              const Text('Place Order', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: kourcolor1),
        ),
      ],
    );
  }

  static Future<Order> fetchOrder(String? userid) async {
    // id = "66657281cc66b0be50ff9f80";
    // final response;

    final ipAddress =
        await getLocalIPv4Address(); // Ensure this function is correctly implemented
    try {
      final response =
          await http.get(Uri.parse('http://$ipAddress:5000/order/$userid'));
      print('Response body in fetchOrder : ${response.body}');
      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        // print('Decoded JSON: $decoded');
        return Order.fromJson(decoded);
      } else {
        print('Failed to load order, Status code: ${response.statusCode}');
        throw Exception(
            'Failed to load order, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making request: $e');
      rethrow;
    }
  }
}
