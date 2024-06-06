import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/product.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/product_card.dart';

class BraceletPage extends StatefulWidget {
  const BraceletPage({super.key});

  @override
  State<BraceletPage> createState() => _BraceletPageState();
}

class _BraceletPageState extends State<BraceletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(width: 25), // Add space here if needed
          Text(
            '     Bracelet         ',
            style: TextStyle(
              fontSize: 35,
              //  fontWeight: FontWeight.bold,
              // fontFamily: "Libre_Baskerville",
              color: kourcolor1,
            ),
          ),
          SizedBox(width: 10), // Add space here if needed
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
      // backgroundColor: Color(0xFFDFDED9),
      backgroundColor: Colors.white,
      /*  body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              ///Dropdown
              DropdownButtonFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.filter_list_outlined)),
                  onChanged: (value) {},
                  items: [
                    'Name',
                    'Higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popularity'
                  ]
                      .map((option) =>
                          DropdownMenuItem(value: option, child: Text(option)))
                      .toList()),
              const SizedBox(height: 32.0),

              ///products
              //   GridLayout(itemCount: 4, itemBuilder: (_, index)=>const ProductCard(product: products[index]))
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //  alignment: Alignment.center,
                          child: Text(
                            "Special For You",
                            style: TextStyle(
                              color: kourcolor1,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Libre_Baskerville",
                            ),
                          ),
                        ),
                        Container(
                          //     alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                color: kourcolor1,
                                fontSize: 15,
                                fontFamily: "Libre_Baskerville",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), */
    );
  }
}
