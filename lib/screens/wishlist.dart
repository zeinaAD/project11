import 'package:flutter/material.dart';
import 'package:project1/models/wishlistProduct.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/wishlist_card.dart';
import 'package:project1/models/product.dart';
import 'package:project1/widgets/product_card.dart';

class wishlist extends StatefulWidget {
  final Product product;

  const wishlist({Key? key, required this.product}) : super(key: key);

  @override
  State<wishlist> createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //   backgroundColor: Color.fromARGB(187, 22, 21, 21),
          elevation: 0,
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
          title: Text('WishList',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: kourcolor1,
              )),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Text('Edit    ',
                    style: TextStyle(
                      color: kourcolor1,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ]),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                //  color: Color.fromARGB(221, 234, 231, 231),
                color: Colors.grey[100],
                child: TabBar(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  labelColor: kourcolor1,
                  indicatorColor: kourcolor1,
                  unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    Tab(
                      text: "All Item",
                    ),
                    Tab(
                      text: "Boards",
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "3 Items Found",
                      style: TextStyle(color: Colors.grey[400]),
                    )),
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      mainAxisExtent: 280,
                    ),
                    itemCount: Wproducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: widget.product); /////
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
