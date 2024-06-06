import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/product.dart';
import 'package:project1/utilities/constants.dart';

class ProductDescription extends StatefulWidget {
  final Product product;
  const ProductDescription({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white), // Add black border
          borderRadius: BorderRadius.circular(0),
        ),
        child: GestureDetector(
          onTap: () {
            _display(context);
          },
          child: Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Color(0xFFDFDED9),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _display(context);
                  },
                  child: Row(children: [
                    Text('Product Description    ',
                        style: TextStyle(
                          color: kourcolor1,
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      width: 110,
                    ),
                    Icon(Icons.arrow_circle_right)
                  ]),
                ),
              ],
            ),
          ),
        ));
  }

  Future _display(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: kourcolor1),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color.fromARGB(159, 230, 226, 226),
                ),
                height: 700,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text('Product Description',
                          style: TextStyle(
                            color: kourcolor1,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    //  Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1.5,
                      width: 500,
                      color: Color(0x9F201E1E),
                    ),
                    Container(
                      child: Text(
                        //  'plplpplplplpplpaaaaaaaaaaaaaaaaajbcjc d,ncdhcbd cn v',
                        widget.product.rate!,
                        style: TextStyle(
                            color: kourcolor1,
                            //fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
