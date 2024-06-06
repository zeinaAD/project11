import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/D_appbar.dart';
import 'package:project1/widgets/G_appbar.dart';
import 'package:project1/widgets/background-image.dart';
import 'package:project1/widgets/diamondCategories.dart';
import 'package:project1/widgets/product_card.dart';
import 'package:project1/widgets/search_aboutD.dart';
import 'package:project1/widgets/search_aboutG.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<GoldScreen> createState() => _GoldScreenState();
}

class _GoldScreenState extends State<GoldScreen> with TickerProviderStateMixin {
  List<String> assets = [
    'images/diam1.jpg',
    'images/gold1.jpg',
    'images/ring.jpg',
    //'images/gold1.jpg',
    // 'images/gold1.jpg'
  ];
  final color = [
    Color(0xA5FFFFFF),
    Color(0xA5FFFFFF),
    Color(0xA5FFFFFF),
    // Colors.blueGrey,
    // Colors.blue,
  ];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //  backgroundColor: Color(0xFFDFDED9),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/IRIS3.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              G_AppBar(),
              /* SizedBox(
                height: 8,
              ), */
              SearchG(),
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: assets.length,
                  physics: BouncingScrollPhysics(),
                  controller:
                      PageController(initialPage: 0, viewportFraction: 0.9),
                  onPageChanged: (value) {
                    currentindex = value;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          //  color: color[index],
                          borderRadius: BorderRadius.circular(25)),
                      child: Image.asset(
                        assets[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              TabPageSelector(
                controller: TabController(
                    length: assets.length,
                    initialIndex: currentindex,
                    vsync: this),
                selectedColor: kourcolor1,
                color: Color(0xA5FFFFFF),
                borderStyle: BorderStyle.none,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1,
                  ),
                ),
              ),
              DCategories(),
              SizedBox(
                height: 15,
              ),
              /* Container(
                height: 400,
                width: 400,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DesignRing()),
                    );
                  },
                  child: ClipOval(
                    child: Ink.image(
                      image: AssetImage("images/DYR.png"),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                /*   decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ), */
              ), */
              /* GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'DesignRingScreen'),
                child: Container(
                  child: Text('Design your Own Ring',
                      style: TextStyle(
                        color: kourcolor1,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kourcolor1))),
                ),
              ), */
              SizedBox(
                height: 15,
              ),
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // GridView.builder(
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 20,
                    //     mainAxisSpacing: 20,
                    //   ),
                    //   itemCount: products.length,
                    //   itemBuilder: (context, index) {
                    //     return ProductCard(product: products[index]);
                    //   },
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}
