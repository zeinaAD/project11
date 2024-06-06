import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class SearchP extends StatefulWidget {
  const SearchP({super.key});

  @override
  State<SearchP> createState() => _SearchPState();
}

class _SearchPState extends State<SearchP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, color: Color(0x9F201E1E)), // Add black border
        borderRadius: BorderRadius.circular(0),
      ),
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
          children: [
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.search,
                color: kourcolor1,
              ),
            ),
            const SizedBox(width: 10),
            const Flexible(
              flex: 4,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search ...",
                  hintStyle: TextStyle(color: kourcolor1),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 25,
              width: 1.5,
              color: kourcolor1,
            ),
            const SizedBox(width: 15),
            /* MaterialButton(
              onPressed: () {
                _display(context);
              },
              child: Text('Sort'), // Add text or any other child widget
              color: Colors.white, // Set background color
              textColor: kourcolor1, // Set text color
              padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: 24), // Set padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Set border radius
                side: BorderSide(
                    color: Colors.white), // Set border color and width
              ),
            ), */
            GestureDetector(
              onTap: () {
                _display(context);
              },
              child: Container(
                child: Text('Sort    ',
                    style: TextStyle(
                      color: kourcolor1,
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                    )),
                /*  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: kourcolor1))), */
              ),
            ),
          ],
        ),
      ),
    );
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
                      child: Text('SORT BY',
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
                      child: ListTile(
                        title: Text(
                          'Name',
                          style: TextStyle(
                            color: kourcolor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // Handle item 1 tap
                          Navigator.pop(
                              context); // Close the bottom sheet if needed
                        },
                      ),
                    ),
                    Container(
                      height: 1.5,
                      width: 500,
                      color: Color(0x9F201E1E),
                    ),

                    //Divider(),
                    Container(
                      child: ListTile(
                        title: Text(
                          'Higher Price',
                          style: TextStyle(
                            color: kourcolor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // Handle item 2 tap
                          Navigator.pop(
                              context); // Close the bottom sheet if needed
                        },
                      ),
                    ),
                    Container(
                      height: 1.5,
                      width: 500,
                      color: Color(0x9F201E1E),
                    ),

                    Container(
                      child: ListTile(
                        title: Text(
                          'Lower Price',
                          style: TextStyle(
                            color: kourcolor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // Handle item 2 tap
                          Navigator.pop(
                              context); // Close the bottom sheet if needed
                        },
                      ),
                    ),

                    //Divider(),
                    Container(
                      height: 1.5,
                      width: 500,
                      color: Color(0x9F201E1E),
                    ),

                    Container(
                      child: ListTile(
                        title: Text(
                          'Sale',
                          style: TextStyle(
                            color: kourcolor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // Handle item 2 tap
                          Navigator.pop(
                              context); // Close the bottom sheet if needed
                        },
                      ),
                    ),

                    Container(
                      height: 1.5,
                      width: 500,
                      color: Color(0x9F201E1E),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          'Newest',
                          style: TextStyle(
                            color: kourcolor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // Handle item 2 tap
                          Navigator.pop(
                              context); // Close the bottom sheet if needed
                        },
                      ),
                    ),

                    Container(
                      height: 1.5,
                      width: 500,
                      color: Color(0x9F201E1E),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          'Popularity',
                          style: TextStyle(
                            color: kourcolor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // Handle item 2 tap
                          Navigator.pop(
                              context); // Close the bottom sheet if needed
                        },
                      ),
                    ),
                    Container(
                      height: 1.5,
                      width: 500,
                      color: Color(0x9F201E1E),
                    ),
                  ],
                ),
              ),
            ));
  }
}
