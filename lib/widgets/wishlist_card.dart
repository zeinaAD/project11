import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:project1/models/product.dart';
import 'package:project1/models/wishlistProduct.dart';
import 'package:project1/screens/necklace_page.dart';
import 'package:project1/screens/productDetails.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/rounded-button1.dart';
import 'package:project1/screens/home_page.dart';

class WishlistCard extends StatefulWidget {
  // final wishlistProduct wishlistproduct;
  final Product product;
  const WishlistCard({super.key, required this.product});

  @override
  State<WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.product.title.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 4,
      blurBackgroundColor: Colors.black,
      menuWidth: MediaQuery.of(context).size.width * 0.5,
      animateMenuItems: false,
      duration: Duration(milliseconds: 200),
      menuBoxDecoration: BoxDecoration(
        color: kourcolor1,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: widget.product),
          ),
        );
      },
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
            title: Text("Open"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetails(product: widget.product),
                ),
              );
            },
            trailingIcon: Icon(Icons.open_in_new)),
        FocusedMenuItem(
            title: Text("Share"),
            onPressed: () {},
            trailingIcon: Icon(Icons.share)),
        FocusedMenuItem(
            backgroundColor: Colors.redAccent,
            title: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
            trailingIcon: Icon(
              Icons.delete,
              color: Colors.white,
            )),
      ],
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kourcolor1), // Add border here
          borderRadius: BorderRadius.circular(
              16.0), // Adjust border radius as per your design
        ),
        height: 300,
        width: 200,
        padding: const EdgeInsets.all(1),
        //  color: kourcolor1,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Image.network(
                widget.product.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 30,
              left: 10,
              child: Text(
                "${widget.product.title}",
                style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                '\$${widget.product.price.toString()}',
                style: Theme.of(context).textTheme.subtitle2!.merge(
                      TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade500,
                      ),
                    ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 10,
              child: Container(
                width: 50,
                height: 50,
                child: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: kourcolor1,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class WishlistItem {
//   final String name;
//   // final String id;
//   final int price;
//   // final int quantity;
//   final String productId;

//   WishlistItem(
//       {required this.name,
//       required this.price,
//       //  required this.id,
//       required this.productId});

//   // Assuming a static method is useful here if needed
//   factory WishlistItem.fromJson(Map<String, dynamic> json) {
//     return WishlistItem(
//       name: json['productName'] as String? ??
//           'default-name', // Since 'name' isn't provided
//       productId: json['productId'] as String? ??
//           'default-product-id', // Adjust as necessary
//       // quantity: json['quantity'] as int? ?? 0,
//       price: json['price'] as int? ?? 0,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'productName': name,
//       'productId': productId,
//       'price': price,
//       // 'quantity': quantity,
//     };
//   }
// }
