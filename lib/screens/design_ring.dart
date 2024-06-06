import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/models/designRings.dart';

class DesignRing extends StatefulWidget {
  const DesignRing({super.key, required this.name});
  final String name;

  @override
  State<DesignRing> createState() => _DesignRingState();
}

class _DesignRingState extends State<DesignRing> {
  String stone_choice = "";
  String shape_choice = "";
  String side_choice = "";
  String currentImagePath = "project1/images/ring5.jpg"; // Default image path
  String imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/gradprojfb.appspot.com/o/items%2Fitem_1716060796603_100.jpg?alt=media&token=9ecb5d82-3d3a-40f3-95d1-8e4424593cac";
  String rname = "";
  String name = "";
  String price = "";
  late Future<Set<design>> futureDYR;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    futureDYR = design.DYRfetching(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          iconSize: 35,
          icon: const Icon(
            Icons.more_vert_outlined,
            color: kourcolor1,
          ),
        ),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Color.fromARGB(221, 241, 235, 235),
              ),
            ),
            child: Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                color: Color.fromARGB(221, 241, 235, 235),
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
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            iconSize: 35,
            icon: const Icon(
              Icons.notifications_active,
              color: kourcolor1,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<Set<design>>(
        future: futureDYR,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found.'));
          } else {
            final designItem = snapshot.data!.first;
            if (rname.isEmpty && price.isEmpty) {
              imageUrl = designItem.image;
              rname = designItem.rname;
              price = designItem.price;
            }
            return buildContent(size);
          }
        },
      ),
    );
  }

  Widget buildContent(Size size) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          SizedBox(height: 15),
          Container(
            alignment: Alignment.center,
            child: Text(
              rname,
              style: TextStyle(
                fontSize: 20,
                color: Color(0x9F201E1E),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      imageUrl =
                          'https://firebasestorage.googleapis.com/v0/b/gradprojfb.appspot.com/o/items%2Fitem_1716060796603_100.jpg?alt=media&token=9ecb5d82-3d3a-40f3-95d1-8e4424593cac';
                      price = "1000";
                      rname = "ROUNDED SHAPE DIAMOND RING";
                    });
                  },
                  iconSize: 35,
                  icon: const Icon(
                    Icons.autorenew,
                    color: Color(0x9F201E1E),
                  ),
                ),
                Text('   Start',
                    style: TextStyle(
                      color: Color(0x9F201E1E),
                      fontSize: 13,
                    )),
                Text('   Over',
                    style: TextStyle(
                      color: Color(0x9F201E1E),
                      fontSize: 13,
                    )),
              ],
            ),
          ),
          Container(
            height: 250,
            width: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 40,
            color: Color(0x9FC6C2C2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$$price",
                  style: TextStyle(
                    color: kourcolor1,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: size.height * 0.04,
                  width: size.width * 0.45,
                  decoration: BoxDecoration(),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kourcolor1),
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                        (states) => BorderSide(
                          color: kourcolor1,
                          width: 2,
                        ),
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Additional UI elements go here
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   CENTER STONE',
                  style: TextStyle(
                    color: kourcolor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            stone_choice = "diamond";
                          },
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/csd.png"),
                              height: 90,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            stone_choice = "sapphire";
                          },
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/css.png"),
                              height: 90,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            stone_choice = "emerald";
                          },
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/cse.png"),
                              height: 90,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            stone_choice = "tanzanite";
                          },
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/cst.png"),
                              height: 90,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            stone_choice = "ruby";
                          },
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/csr.png"),
                              height: 90,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Center stone shape selection
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   CENTER STONE SHAPE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kourcolor1,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            shape_choice = "round";
                          },
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/rs.PNG"),
                              height: 100,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            shape_choice = "oval";
                          },
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/os.PNG"),
                              height: 100,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/prs.PNG"),
                              height: 100,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: ClipOval(
                            child: Ink.image(
                              image: AssetImage("images/ps.PNG"),
                              height: 100,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Side setting selection
          SizedBox(height: 10),
          // Ring size selection
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   RING SIZE',
                  style: TextStyle(
                    color: kourcolor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Wrap(
                    spacing: 8.0, // Horizontal spacing between chips
                    runSpacing: 4.0, // Vertical spacing between lines
                    children: [
                      for (String size in [
                        "4",
                        "4.5",
                        "5",
                        "5.5",
                        "6",
                        "6.5",
                        "7",
                        "7.5",
                        "8",
                        "8.5",
                        "9"
                      ])
                        Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              size,
                              style: TextStyle(
                                color: kourcolor1,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Done button
          SizedBox(height: 10),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.8,
            decoration: BoxDecoration(),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  Set<design> response;
                  response =
                      await design.DYRfetching("$shape_choice $stone_choice");
                  setState(() {
                    imageUrl = response.first.image;
                    rname = response.first.rname;
                    price = response.first.price;
                  });
                  _scrollController.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeOut,
                  );
                } catch (e) {
                  print('Failed to fetch image: $e');
                  setState(() {
                    currentImagePath = 'images/error.jpg';
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kourcolor1),
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (states) => BorderSide(
                    color: kourcolor1,
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              child: Text(
                'DONE AND SHOW THE PRICE',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Wishlist button
          SizedBox(height: 10),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.8,
            decoration: BoxDecoration(),
            child: ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kourcolor1),
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (states) => BorderSide(
                    color: kourcolor1,
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ADD TO WISHLIST',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          // Chat section
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            width: 330,
            height: 90,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  iconSize: 35,
                  icon: const Icon(
                    Icons.wechat_outlined,
                    color: kourcolor1,
                  ),
                ),
                Column(children: [
                  Text('Have a question about Ring?',
                      style: TextStyle(
                          color: kourcolor1,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'chatPage'),
                    child: Container(
                      child: Text('Chat Now',
                          style: TextStyle(
                            color: kourcolor1,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: kourcolor1))),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
