import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/screens/login1.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/designRing.dart';
import 'package:project1/widgets/itemInfo.dart';
import 'package:project1/widgets/iteminfo2.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Uint8List? _image;
  File? selectedIMage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),

            /*  _image != null
                ? CircleAvatar(
                    radius: 100, backgroundImage: MemoryImage(_image!))
                : const CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                  ), */
            SizedBox(
              height: 180,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      //  showInformation(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ItemInfo()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kourcolor1),
                      fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(),
                      ),
                    ),
                    child: Text(
                      "for items",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      //  showInformation(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ItemInfo2()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kourcolor1),
                      fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(),
                      ),
                    ),
                    child: Text(
                      "for gold items",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      //  showImagePickerOption(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => designRing()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kourcolor1),
                      fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(),
                      ),
                    ),
                    child: Text(
                      "for design your own ring",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => RingFingerDetection(),
                      // ));
                      //  showImagePickerOption(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kourcolor1),
                      fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(),
                      ),
                    ),
                    child: Text(
                      "for i dont know",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => loginpagee(),
                      ));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kourcolor1),
                      fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showInformation(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 4.5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //  showImagePickerOption(context);
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(8.0),
                        strokeWidth: 2,
                        dashPattern: [5, 5],
                        color: kourcolor1, // Color of the border
                        child: Container(
                          width: 250,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white, // Add background color
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the border radius as needed
                          ),
                          child: Center(
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(
                                      _image!,
                                      width: 250, // Adjust the width as needed
                                      height:
                                          150, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Icon(
                                        Icons.image,
                                        size: 70,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Add Image here',
                                        style: TextStyle(
                                          color: kourcolor1,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Item Type...',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Item Name...',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Item Price...',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kourcolor1),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(110, 50)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(),
                              ),
                            ),
                            child: Text(
                              "Save",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kourcolor1),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(110, 50)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
