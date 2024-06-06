import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/D_appbar.dart';
import 'package:project1/widgets/UserPreferences.dart';
import 'package:project1/widgets/diamondCategories.dart';
import 'package:project1/widgets/productDescription.dart';
import 'package:project1/widgets/product_card.dart';
import 'package:project1/widgets/search_aboutD.dart';
import 'package:project1/widgets/sizeSlider.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  double _value = 4;
  Color _statusColor = kourcolor1;
  List<String> assets = [
    'images/ring3.jpg',
    'images/ring3.jpg',
    'images/ring3.jpg',
  ];
  final color = [
    Color(0xA5FFFFFF),
    Color(0xA5FFFFFF),
    Color(0xA5FFFFFF),
  ];
  int currentindex = 0;
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 100,
          child: Row(children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: kourcolor1,
                size: 35,
              ),
              onPressed: () {
                // Handle favorite button press
              },
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  onPressed: () {
                    //call future
                    addItemToCart(
                        userId: UserPreferences.getUserID(),
                        productId: widget.product.id,
                        //   " ", //////////////////////////////////change this
                        quantity: _quantity,
                        size: _value);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kourcolor1),
                    fixedSize: MaterialStateProperty.all(const Size(80, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(),
                    ),
                  ),
                  child: Text(
                    "Add To Cart",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ]),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              size: 30,
              Icons.arrow_back_ios,
              color: kourcolor1,
            ),
          ),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color:
                        Color.fromARGB(221, 241, 235, 235)), // Add black border
                //      borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  // color: Color(0xFFDFDED9),
                  color: Color.fromARGB(221, 241, 235, 235),
                  //     borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      iconSize: 25,
                      icon: const Icon(
                        Icons.search,
                        color: kourcolor1,
                      ),
                    ),
                    const Flexible(
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search ...",
                          hintStyle: TextStyle(color: kourcolor1, fontSize: 15),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),

            // Add space here if needed
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.shopping_cart,
                color: kourcolor1,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xDDE1DEDE),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 450,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Image.network(
                            /////////////////////////////////////image
                            widget.product.image,
                            width: double.infinity,
                            height: 450,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 1500,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  widget.product.title!.replaceAll('\\n', '\n'),

                                  /////////////////////////////name
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                const SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  color: Colors.white,
                                  child: Text(
                                    //////////////////////////////price
                                    widget.product.price!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kourcolor1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 1.5,
                              width: 700,
                              color: Color(0x9F201E1E),
                            ),
                            ///////////////////////
                            ProductDescription(
                                product: widget
                                    .product), //////////////////description

                            Container(
                              height: 1.5,
                              width: 700,
                              color: Color(0x9F201E1E),
                            ),
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Text(
                                      "Size : ",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 20,
                                        //fontWeight: FontWeight.bold,
                                        color: kourcolor1,
                                      ),
                                    ),
                                    Text(
                                      _value.toStringAsFixed(1),
                                      style: TextStyle(
                                        color: kourcolor1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                                  SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: kourcolor1,
                                        overlayColor: Color(0x9F201E1E),
                                        thumbColor: kourcolor1,
                                        trackHeight: 5.0,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 8.0),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 16.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Slider(
                                            min: 4.0,
                                            max: 9.0,
                                            divisions:
                                                ((9.0 - 4.0) * 2).toInt(),
                                            value: _value,
                                            onChanged: (double val) {
                                              setState(() {
                                                _value = (val * 2).round() /
                                                    2; // Round to the nearest 0.5
                                              });
                                            },
                                          ),
                                        ],
                                      ))
                                ]),

                            Container(
                              height: 1.5,
                              width: 700,
                              color: Color(0x9F201E1E),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Quantity",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20,
                                      //fontWeight: FontWeight.bold,
                                      color: kourcolor1,
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 60,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () => setState(() {
                                            _quantity--;
                                          }),
                                          child: CircleAvatar(
                                            radius: 22,
                                            backgroundColor: Color.fromARGB(
                                                159, 188, 183, 183),
                                            child: Icon(Icons.remove),
                                          ),
                                        ),
                                        Text(
                                          "$_quantity",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        InkWell(
                                          onTap: () => setState(() {
                                            _quantity++;
                                          }),
                                          child: CircleAvatar(
                                            radius: 22,
                                            backgroundColor: Color.fromARGB(
                                                159, 188, 183, 183),
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),

                            Container(
                              height: 1.5,
                              width: 700,
                              color: Color(0x9F201E1E),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              height: 130,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }
  /////////future function

  Future<void> addItemToCart({
    required String? userId,
    required String? productId,
    required int quantity,
    double? size,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse(
        'http://$ipAddress:5000/addtoCart'); // Change to your actual server URL
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'size': size,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Item added to cart successfully');
      } else {
        throw Exception('Failed to add item to cart: ${response.body}');
      }
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }
}
