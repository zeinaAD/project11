import 'package:flutter/material.dart';
import 'package:project1/main.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/shipping_info.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/navigation_drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:project1/widgets/UserPreferences.dart';

class profile extends StatefulWidget {
  // final TextEditingController emailController;

  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  int selectedIndex = 0;
  String? name;
  // getUserData();
  void initState() {
    super.initState();
    // getUserData();
  }

  void _navigateBottomBar(int index) {
    setState(() {
      //  getUserData();
      selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
          break;
        case 1:
          // Handle shopping cart icon tap
          break;
        case 2:
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => wishlist()),
          ); */
          break;
        case 3:
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => profile()),
          ); */
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final email = widget.emailController.text;
    // final emailProvider = Provider.of<EmailProvider>(context);
    // final email = emailProvider.email;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(color: kourcolor1, Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(color: kourcolor1, Icons.add_shopping_cart),
              label: 'Shop Now'),
          BottomNavigationBarItem(
              icon: Icon(color: kourcolor1, Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(color: kourcolor1, Icons.account_box),
              label: 'Account'),
        ],
      ),
      //  drawer: NavigationDrawerWidget(),
      appBar: AppBar(
          title: Text(
            'My Account',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: kourcolor1,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            SizedBox(width: 2),
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
          ]),
      body: Container(
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 5,
              color: Color(0xDDF1EBEB),
              // child: Divider(),
            ),
            SizedBox(
              height: 10,
            ),
            // SizedBox(height: 32),
            Column(
              children: <Widget>[
                Text(
                  'I R I S',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1, // Use primary color here
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Hello ${UserPreferences.getUserName()}!\n Email:${UserPreferences.getEmail()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kourcolor1, // Use primary color here
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                  // child: Divider(),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.white), // Add black border
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShippingInformationPage()),
                        );
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
                              Text('  MY ORDERS    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                  // child: Divider(),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.white), // Add black border
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => wishlist()),
                        ); */
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
                              Text('  MY FAVORITES    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                  // child: Divider(),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.white), // Add black border
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Cart()),
                        ); */
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
                              Text('  PROFILE    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                  // child: Divider(),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.white), // Add black border
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Cart()),
                        ); */
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
                              Text('  ADDRESS BOOK    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                  // child: Divider(),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.white), // Add black border
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Cart()),
                        );
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
                              Text('  ACCOUNT DELETION    ',
                                  style: TextStyle(
                                    color: kourcolor1,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              )
                            ]),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0xDDF1EBEB),
                  // child: Divider(),
                ),
              ],
            ),

            SizedBox(
              height: 140,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'SIGN OUT',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kourcolor1,
                shape: RoundedRectangleBorder(
                    //  borderRadius: BorderRadius.circular(18.0),
                    ),
                minimumSize: Size(380, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
