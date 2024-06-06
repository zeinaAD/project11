// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:focused_menu/focused_menu.dart';
// import 'package:focused_menu/modals.dart';
// import 'package:project1/ipaddress.dart';
// import 'package:project1/models/product.dart';
// import 'package:project1/screens/productDetails.dart';
// import 'package:project1/screens/shipping_info.dart';
// import 'package:project1/screens/wishlist.dart';
// import 'package:project1/screens/order_review.dart'; // Ensure you import OrderReviewPage
// import 'package:project1/utilities/constants.dart';
// import 'package:http/http.dart' as http;

// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             size: 30,
//             Icons.arrow_back_ios,
//             color: kourcolor1,
//           ),
//         ),
//         title: Text('Cart',
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//               color: kourcolor1,
//             )),
//         centerTitle: true,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.favorite_border,
//               color: kourcolor1,
//               size: 30,
//             ),
//             onPressed: () {
//               /* Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => wishlist()),
//               ); */
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemBuilder: (_, index) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: FocusedMenuHolder(
//                   menuItems: <FocusedMenuItem>[
//                     FocusedMenuItem(
//                         title: Text("Open"),
//                         onPressed: () {
//                           /*  Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ProductDetails(product: widget.product),
//               ),
//             ); */
//                         },
//                         trailingIcon: Icon(Icons.open_in_new)),
//                     FocusedMenuItem(
//                         title: Text("Share"),
//                         onPressed: () {},
//                         trailingIcon: Icon(Icons.share)),
//                     FocusedMenuItem(
//                         backgroundColor: Colors.redAccent,
//                         title: Text(
//                           "Delete",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () {},
//                         trailingIcon: Icon(
//                           Icons.delete,
//                           color: Colors.white,
//                         )),
//                   ],
//                   animateMenuItems: true,
//                   blurSize: 4,
//                   blurBackgroundColor: Colors.black,
//                   menuWidth: MediaQuery.of(context).size.width * 0.5,
//                   duration: Duration(milliseconds: 200),
//                   menuBoxDecoration: BoxDecoration(
//                     color: kourcolor1,
//                   ),
//                   onPressed: () {},
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xDDF1EBEB), width: 5),
//                     ),
//                     child: cartItem(),
//                   ),
//                 ),
//               ),
//               itemCount: 3,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0), // Add padding for better UI
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ShippingInformationPage()),
//                 );
//               },
//               child: Text(
//                 'Checkout',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: kourcolor1,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class cartItem extends StatefulWidget {
//   const cartItem({super.key});

//   @override
//   State<cartItem> createState() => _cartItemState();
// }

// class _cartItemState extends State<cartItem> {
//   String _selectedSize = "Size 5"; // Default selected size
//   int _quantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Stack(
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 110,
//                 height: 110,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                         'images/ring1.jpg'), // Provide your image path here
//                     fit: BoxFit.contain, // Adjust the fit of the image
//                   ),
//                   color: kourcolor1,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               SizedBox(
//                 width: 8,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Text(
//                     " Diamond Ring",
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                     height: 20,
//                     width: 80, // Increased width to accommodate the icon
//                     decoration: BoxDecoration(
//                       color: Color(0xDDF1EBEB),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Center(
//                       child: Builder(
//                         builder: (BuildContext context) {
//                           return Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 _selectedSize,
//                                 style: TextStyle(
//                                   color: const Color.fromARGB(255, 98, 96, 96),
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   final RenderBox renderBox =
//                                       context.findRenderObject() as RenderBox;
//                                   final Offset offset =
//                                       renderBox.localToGlobal(Offset.zero);
//                                   showMenu(
//                                     context: context,
//                                     position: RelativeRect.fromLTRB(
//                                       offset.dx,
//                                       offset.dy + renderBox.size.height,
//                                       offset.dx + renderBox.size.width,
//                                       0,
//                                     ),
//                                     items: [
//                                       PopupMenuItem(
//                                         child: menuSize(
//                                           onSelectSize: (size) {
//                                             updateSelectedSize(size);
//                                             Navigator.pop(context);
//                                           },
//                                         ),
//                                         height: 400, // Increased height
//                                       ),
//                                     ],
//                                   );
//                                 },
//                                 child: Icon(
//                                   Icons.expand_more,
//                                   color: const Color.fromARGB(255, 98, 96, 96),
//                                   size: 20,
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 0,
//             left: 125,
//             child: Text(
//               "\$1000",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 30,
//             right: 0,
//             child: IconButton(
//               icon: Icon(
//                 Icons.favorite_border,
//                 color: kourcolor1,
//                 size: 30,
//               ),
//               onPressed: () {},
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 305,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 1),
//               decoration: BoxDecoration(
//                 color: Color(0xDDF1EBEB),
//                 border: Border.all(color: kourcolor1, width: 1),
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () => setState(() {
//                       if (_quantity > 1) {
//                         _quantity--;
//                       }
//                     }),
//                     child: CircleAvatar(
//                       radius: 10,
//                       backgroundColor: Colors.white,
//                       child: Icon(
//                         Icons.remove,
//                         size: 15,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 3,
//                   ),
//                   Text(
//                     "$_quantity",
//                     style: TextStyle(fontSize: 15),
//                   ),
//                   SizedBox(
//                     width: 3,
//                   ),
//                   InkWell(
//                     onTap: () => setState(() {
//                       _quantity++;
//                     }),
//                     child: CircleAvatar(
//                       radius: 10,
//                       backgroundColor: Colors.white,
//                       child: Icon(
//                         Icons.add,
//                         size: 15,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void updateSelectedSize(String size) {
//     setState(() {
//       _selectedSize = "Size $size"; // Update to display "Size {number}"
//     });
//   }
// }

// class menuSize extends StatefulWidget {
//   final Function(String) onSelectSize;
//   const menuSize({super.key, required this.onSelectSize});

//   @override
//   State<menuSize> createState() => _menuSizeState();
// }

// class _menuSizeState extends State<menuSize> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 400, // Increased height
//       child: ListView(
//         children: [
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("4");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("4"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("4.5");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("4.5"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("5");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("5"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("5.5");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("5.5"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("6");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("6"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("6.5");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("6.5"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("7");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("7"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("7.5");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("7.5"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("8");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("8"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("8.5");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("8.5"),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               widget.onSelectSize("9");
//             },
//             child: Container(
//               height: 30,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 5),
//               padding: EdgeInsets.all(5),
//               child: Text("9"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

///////////////////////////////////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/ipaddress.dart';
import 'dart:convert';

import 'package:project1/models/product.dart'; // Ensure this model is correctly set up for JSON parsing
import 'package:project1/utilities/constants.dart'; // Contains constant values used in the app
import 'package:project1/widgets/UserPreferences.dart'; // Manages user preferences, like userID

class Cart extends StatefulWidget {
  const Cart({Key? key})
      : super(key: key); // updated to current Dart null-safety standard

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // late Future<List<Map<String, dynamic>>> futureCartItems;
  late Future<List<dynamic>> futureCartItems;

  @override
  void initState() {
    super.initState();
    // Fetching the user ID and loading cart items asynchronously on init
    futureCartItems = fetchCartItem(UserPreferences.getUserID());
  }

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
                  title: Text(
                      item['productName'] ?? 'No product name'), // Product name
                  subtitle: Text(
                      'Quantity: ${item['quantity'].toString()}'), // Quantity from the cart item
                  trailing: Text(
                      '\$${item['productPrice'].toString()}'), // Product price
                );
              },
            );
          } else {
            return const Center(child: Text('No items in your cart'));
          }
        },
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
        print("data" + data);
        print("data items:" + data['items']);

        return data[
            'items']; // Assuming the API returns an object with an 'items' key
      } else {
        throw Exception(
            'Failed to load cart products, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      throw Exception('Failed to load cart products: $e');
    }
  }
}
