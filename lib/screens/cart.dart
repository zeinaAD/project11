import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/ipaddress.dart';
import 'dart:convert';

import 'package:project1/models/product.dart'; // Ensure this model is correctly set up for JSON parsing
import 'package:project1/screens/shipping_info.dart';
import 'package:project1/utilities/constants.dart'; // Contains constant values used in the app
import 'package:project1/widgets/UserPreferences.dart'; // Manages user preferences, like userID

class Cart extends StatefulWidget {
  const Cart({Key? key})
      : super(key: key); // updated to current Dart null-safety standard

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double totalPrice = 0.0;
  late List<CartItem> cartItems;
  String userID = "";

  @override
  void initState() {
    super.initState();
    futureCartItems = Future.value([]);
    _initializeWishlist();
    //futureCartItems = fetchCartItem(UserPreferences.getUserID());
    //futureCartItems.then((_) => _calculateTotalPrice());
  }

  void _initializeWishlist() async {
    String? email = await UserPreferences.getEmail();
    if (email != null) {
      String userId = await UserPreferences.getUserIdByEmail(email);
      setState(() {
        futureCartItems = fetchCartItem(userId);
        userID = userId;
        fetchTotalPrice(userId);
      });
    } else {
      // Handle case when email is null, perhaps navigate to login or show an error
    }
  }

  Future<void> fetchTotalPrice(String userId) async {
    final ipAddress =
        await getLocalIPv4Address(); // Implement this method to get the local IP address
    final url = 'http://$ipAddress:5000/calculateTotalPrice/$userId';
    print('Requesting: $url'); // Debug: log the URL being requested

    try {
      final response = await http.get(Uri.parse(url));
      print(
          'Status code: ${response.statusCode}'); // Debug: log the status code
      print(
          'Response Body: ${response.body}'); // Debug: log the full response body

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          totalPrice = (jsonResponse['totalPrice'] as num).toDouble();
        });

        // return jsonResponse['totalPrice']
        //     .toDouble(); // Convert the total price to double
      } else {
        throw Exception(
            'Failed to load total price, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred: $e');
    }
  }
  // void _calculateTotalPrice() async {
  //   try {
  //     List<dynamic> cartItemsJson = await fetchCartItem(userID);
  //     cartItems = cartItemsJson.map((itemJson) {
  //       int parsedPrice =
  //           int.tryParse(itemJson['productPrice'].toString()) ?? 0;
  //       int parsedQuantity =
  //           int.tryParse(itemJson['productQuantity'].toString()) ?? 0;
  //       return CartItem(
  //         name: itemJson['productName'],
  //         price: parsedPrice,
  //         quantity: parsedQuantity,
  //         productId: itemJson['productId'],
  //       );
  //     }).toList();

  //     double totalPrice = cartItems.fold(0.0,
  //         (previousValue, item) => previousValue + item.price * item.quantity);

  //     setState(() {
  //       _totalPrice = totalPrice;
  //     });
  //   } catch (e) {
  //     print('Error calculating total price: $e');
  //     setState(() {
  //       _totalPrice = 0.0; // Reset or handle error state
  //     });
  //   }
  // }

  late Future<List<dynamic>> futureCartItems;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item['productImage'] ??
                        'default_image_url'), // Provide a default image URL if none is available
                    radius: 25, // You can adjust the size
                  ),
                  title: Text(
                      item['productName'].toString().replaceAll('\\n', '\n') ??
                          'No product name'), // Product name
                  subtitle: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Size: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '${item['productSize'].toString()} '), //modify this to be dynamic
                        TextSpan(
                            text: 'Quantity: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '${item['productQuantity'].toString()}'), ////modify this to be dynamic
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          '\$${(item['productPrice'] * item['productQuantity']).toString()}'), // Product price
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteCartItem(item['productId']),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No items in your cart'));
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Checkout logic here
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShippingInformationPage(cartItems: cartItems)));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      kourcolor1, // Using the primary color from theme
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('CHECKOUT', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchCartItem(String? userId) async {
    final ipAddress = await getLocalIPv4Address();
    try {
      final response = await http
          .get(Uri.parse('http://$ipAddress:5000/fetchCartItems/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic> &&
            data.containsKey('message') &&
            data['message'] == 'Cart is empty') {
          print('Cart is empty');
          return []; // Return an empty list if the cart is empty
        }

        print(data); // Check the simplified structure
        return data['items'];
      } else {
        throw Exception(
            'Failed to load cart products, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      throw Exception('Failed to load cart products: $e');
    }
  }

  void _deleteCartItem(String productId) async {
    final ipAddress = await getLocalIPv4Address();
    userID = UserPreferences.getUserID()!;
    try {
      final response = await http.delete(
        Uri.parse('http://$ipAddress:5000/deleteCartItem/$userID/$productId'),
      );

      if (response.statusCode == 200) {
        // Update the UI to remove the deleted item
        setState(() {
          futureCartItems = fetchCartItem(userID);
          fetchTotalPrice(userID);
        });
      } else {
        throw Exception(
            'Failed to delete cart item, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting cart item: $e');
      throw Exception('Failed to delete cart item: $e');
    }
  }
}

class CartItem {
  final String name;
  final int price;
  final int quantity;
  final String productId;

  CartItem(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.productId});

  // Assuming a static method is useful here if needed
  factory CartItem.fromJson(Map<String, dynamic> json) {
    print("inside from json");
    return CartItem(
      name: json['product_name'] as String? ??
          'default-name', // Since 'name' isn't provided
      productId: json['product_id'] as String? ??
          'default-product-id', // Adjust as necessary
      quantity: json['quantity'] as int? ?? 0,
      price: json['price'] as int? ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'product_name': name,
      'product_id': productId,
      'price': price,
      'quantity': quantity,
    };
  }
}
