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
  //Color _statusColor = kourcolor1;
  int currentindex = 0;
  int _quantity = 0;

  double _fav = 0;

  List<int> ratings = [4, 5, 3, 4, 2];
  List<String> reviews = [
    'This product is amazing! It exceeded my expectations.',
    'I love the color options. They are so vibrant!',
    'The quality of the product is top-notch. Highly recommend.',
    'The price is a bit high, but it\'s worth it for the quality.',
  ];

  void _addReview(String review, int rating) {
    setState(() {
      reviews.add(review);
      ratings.add(rating);
    });
  }

  void _showAddReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddReviewDialog(onSubmit: _addReview);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 100,
          child: Row(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(1, (index) {
                return IconButton(
                  icon: Icon(
                    index < _fav ? Icons.favorite : Icons.favorite_border,
                    size: 35,
                  ),
                  color: kourcolor1,
                  onPressed: () {
                    // print("name:" + widget.product.title.toString());
                    addItemToWishlist(
                      userId: UserPreferences.getUserID(),
                      productId: widget.product.id,
                    );
                    setState(() {
                      // print("name:" + widget.product.title.toString());
                      _fav = index + 1.0;
                    });
                  },
                );
              }),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  onPressed: () {
                    //call future
                    addItemToCart(
                        userId: UserPreferences.getUserID(),
                        productId: widget.product.id);
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
                            // Container(
                            //   height: 1.5,
                            //   width: 700,
                            //   color: Color(0x9F201E1E),
                            // ),
                            ///////////////////////
                            ProductDescription(
                                product: widget
                                    .product), //////////////////description

                            // Container(
                            //   height: 1.5,
                            //   width: 700,
                            //   color: Color(0x9F201E1E),
                            // ),
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

                            // Container(
                            //   height: 1.5,
                            //   width: 700,
                            //   color: Color(0x9F201E1E),
                            // ),
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

                            // SizedBox(
                            //   height: 130,
                            // ),
                            /////////////////////////////////////////
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: kourcolor1),
                                    onPressed: _showAddReviewDialog,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    List.generate(reviews.length, (index) {
                                  return Container(
                                    width: 300,
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: List.generate(
                                              ratings[index], (i) {
                                            return Icon(Icons.star,
                                                color: Colors.yellow, size: 20);
                                          }),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          reviews[index],
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: const Color.fromARGB(
                                                255, 32, 32, 32),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: 130,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /////////future function

  Future<void> addItemToCart({
    required String? userId,
    required String? productId,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:5000/addtoCart');

    // Prepare the body before the request
    final body = json.encode({
      'userId': userId,
      'productId': productId,
      'price': widget.product.price,
      'image': widget.product.image,
      'size': _value,
      'quantity': _quantity
    });

    try {
      // Include the body in your HTTP POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('Item added to cart successfully');
      } else {
        // This will help you understand what the server is actually saying
        throw Exception('Failed to add item to cart: ${response.body}');
      }
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<void> addItemToWishlist({
    required String? userId,
    required String? productId,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse(
        'http://$ipAddress:5000/addtoWishlist'); // Change to your actual server URL
    final headers = {"Content-Type": "application/json"};

    final body = json.encode({
      'userId': userId,
      'productId': productId,
      'name': widget.product.title,
      'image': widget.product.image,
      'price': widget.product.price,
      'description': widget.product.rate
    });
    print(body);

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Item added to wishlist successfully');
      } else {
        throw Exception('Failed to add item to wishlist: ${response.body}');
      }
    } catch (e) {
      print('Error adding item to wishlist: $e');
    }
  }
}

class AddReviewDialog extends StatefulWidget {
  final Function(String, int) onSubmit;
  const AddReviewDialog({required this.onSubmit});

  @override
  _AddReviewDialogState createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 0;
  String _review = '';

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit(_review, _rating.toInt());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted!')),
      );
      Navigator.pop(context); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Review'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 1.5,
              width: 700,
              color: Color(0x9F201E1E),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Rating',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Review'),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your review';
                }
                return null;
              },
              onSaved: (value) {
                _review = value!;
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitReview,
          child: Text(
            'Submit Review',
            /* style: TextStyle(
              color: kourcolor1,
            ), */
          ),
        ),
      ],
    );
  }
}
