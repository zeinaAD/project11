import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/designRings.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/NewArrivals.dart';
import 'package:project1/screens/bestSellers.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/profile.dart';
import 'package:project1/screens/ring_page.dart';
import 'package:project1/screens/suitable_diamond.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/D_appbar.dart';
import 'package:project1/widgets/diamondCategories.dart';
import 'package:project1/widgets/navigation_drawer_widget.dart';
import 'package:project1/widgets/product_card.dart';
import 'package:project1/widgets/search_aboutD.dart';

class DiamondScreen extends StatefulWidget {
  const DiamondScreen({super.key});
  // final design Design;

  @override
  State<DiamondScreen> createState() => _DiamondScreenState();
}

class _DiamondScreenState extends State<DiamondScreen>
    with TickerProviderStateMixin {
  late Future<List<Product>> futureBest;
  List<String> assets = [
    'images/na2.jpeg',
    'images/bs.jpeg',
    // 'images/dis.jpeg',
  ];
  final color = [
    Color(0xA5FFFFFF),
    Color(0xA5FFFFFF),
    Color(0xA5FFFFFF),
    // Colors.blueGrey,
    // Colors.blue,
  ];
  int currentindex = 0;
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    MainScreen(),
  ];
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
          break;
        case 1:
          // Handle shopping cart icon tap
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiamondScreen()),
          );
          break;
        case 2:
          // Handle favorite icon tap
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => wishlist(isDiamond: true,)),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => profile()),
          );
          break;
        default:
          break;
      }
    });
  }

  void _onImageTap(int index) {
    switch (index) {
      case 0: //new arrivals
        futureBest = Product.fetchNewArrivals();

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RingPage(
                    category: 'new',
                    title: '        New Arrivals    ',
                  )),
        );
        break;
      case 1: //best sellers
        // futureBest = Product.fetchBestSellers();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RingPage(
                    category: 'best',
                    title: '        Best Sellers    ',
                  )),
        );
        break;
      // case 2: //discounts

      //   break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(color: kourcolor1, Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(color: kourcolor1, Icons.add_shopping_cart),
                label: 'Shop Now'),
            BottomNavigationBarItem(
                icon: Icon(color: kourcolor1, Icons.favorite),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(color: kourcolor1, Icons.account_box),
                label: 'Account'),
          ],
        ),
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.wechat_outlined,
                color: kourcolor1,
              ),
            ),
            SizedBox(width: 40), // Add space here if needed
            Text(
              'Diamond',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //  fontFamily: "Libre_Baskerville",
                color: kourcolor1,
              ),
            ),
            SizedBox(width: 60), // Add space here if needed
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.notifications_active,
                color: kourcolor1,
              ),
            ),
            SizedBox(width: 2), // Add space here if needed
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()),
                );
              },
              iconSize: 30,
              icon: const Icon(
                Icons.shopping_cart,
                color: kourcolor1,
              ),
            ),
          ],
        ),
        //  backgroundColor: Color(0xFFDFDED9),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              //   SearchD(),
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
                    return InkWell(
                      onTap: () => _onImageTap(index),
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            //   border: Border.all(color: kourcolor1, width: 4),
                          ),
                          child: Image.asset(
                            assets[index],
                            fit: BoxFit.cover,
                          )),
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
                    //    fontFamily: "Libre_Baskerville",
                    color: kourcolor1,
                  ),
                ),
              ),
              DCategories(),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 400,
                width: 400,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DesignRing(
                                name: 'round diamond',
                                //   Design: widget.Design,
                              )),
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
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 400,
                width: 400,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuitableDiamond()),
                    );
                  },
                  child: ClipOval(
                    child: Ink.image(
                      image: AssetImage("images/sd.jpeg"),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Container(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             child: Text(
              //               "Special For You",
              //               style: TextStyle(
              //                 color: kourcolor1,
              //                 fontSize: 24,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //           Container(
              //             child: TextButton(
              //               onPressed: () {},
              //               child: const Text(
              //                 "See all",
              //                 style: TextStyle(
              //                   color: kourcolor1,
              //                   fontSize: 15,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}
