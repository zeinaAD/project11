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
              color: kourcolor1,
            ),
          ),
          SizedBox(width: 10),
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

      backgroundColor: Colors.white,
    
    );
  }
}
