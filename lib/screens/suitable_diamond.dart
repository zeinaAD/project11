// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/utilities/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lottie/lottie.dart';
import 'package:project1/widgets/background-image.dart';
import 'package:project1/widgets/handdetection.dart';

// import 'package:opencv/opencv.dart';
// //import 'package:opencv/core/core.dart';

class SuitableDiamond extends StatefulWidget {
  const SuitableDiamond({Key? key}) : super(key: key);

  @override
  State<SuitableDiamond> createState() => _SuitableDiamondState();
}

class _SuitableDiamondState extends State<SuitableDiamond>
    with SingleTickerProviderStateMixin {
  File? selectedImage;
  Uint8List? _image;
  String imageUrl = " ";
  String? selectedImagePath;

  late AnimationController _animationController;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          iconSize: 35,
          icon: const Icon(
            Icons.menu,
            color: kourcolor1,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            iconSize: 35,
            icon: const Icon(
              Icons.search,
              color: kourcolor1,
            ),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 35,
            icon: const Icon(
              Icons.notifications_active,
              color: kourcolor1,
            ),
          ),
        ],
      ), */
      //backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: BackgroundImage(
              image: 'images/bg2.jpeg',
            ),
            /*  decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF50545A), Color.fromARGB(255, 196, 215, 223)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ), */
          ),
          SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment
                  .center, // Center content vertically in the column

              children: [
                //////////////////////
                selectedImagePath != null
                    ? Container(
                        width: 300, // Specify the width
                        height: 300, // Specify the height
                        child: Image.asset(
                          selectedImagePath!,
                          fit: BoxFit
                              .cover, // This will cover the container area without distorting the aspect ratio
                        ),
                      )
                    : SizedBox(), // Display the image if path is not null
                ///////////////////////////////////////////////////
                //   SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          size: 30,
                          Icons.arrow_back_ios,
                          color: Color(0xFFF1D2D4),
                        ),
                      ),
                      /*  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Lottie.network(
                          'https://lottie.host/beac8430-4aa1-4286-a6ff-eeff0c5bafb7/fjEUJlZNnq.json',
                          width: 200,
                        ),
                      ), */
                    ],
                  ),
                ),
                /*  Positioned(
                  top: 0,
                  right: 30,
                  child: Container(
                    //  width: 50,
                    //   height: 50,
                    /* decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kourcolor1,
                ), */
                    child: Lottie.network(
                      'https://lottie.host/74a06ae7-8674-4c8f-a2e7-cb2cb575b9bb/nlpvDnUPxs.json',
                      width: 150,
                    ),
                  ),
                ), */
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Lottie.network(
                    'https://lottie.host/beac8430-4aa1-4286-a6ff-eeff0c5bafb7/fjEUJlZNnq.json',
                    width: 200,
                  ),
                ),
                /* Center(
                  child: Lottie.network(
                    'https://lottie.host/74a06ae7-8674-4c8f-a2e7-cb2cb575b9bb/nlpvDnUPxs.json',
                    width: 100,
                  ),
                ), */
                SizedBox(
                  height: 40,
                ),
                Text(
                  "PLEASE ENTER YOUR FINGER MEASURMENTS",
                  style: TextStyle(color: Color(0xFFF7CCFC), fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7CCFC),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 2, color: Color(0xFFDFDED9)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Height...",
                              hintStyle: TextStyle(
                                  color: Color(0xFF946699), fontSize: 20),
                              border: InputBorder.none,
                            ),
                            controller: _heightController, ///////////////////
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7CCFC),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 2, color: Color(0xFFDFDED9)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Width...",
                              hintStyle: TextStyle(
                                  color: Color(0xFF946699), fontSize: 20),
                              border: InputBorder.none,
                            ),
                            controller: _widthController,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      //  showImageDialog(context);
                      calculate(_heightController.text,
                          _widthController.text); ///////////////
                      // Image.asset(
                      //   // selectedImagePath!,
                      //   'images/pear.jpeg',
                      //   width: 100,
                      //   height: 100,
                      //   fit: BoxFit.cover,
                      // );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF7CCFC)),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      'Enter',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF946699),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () => uploadimage(context),
                  child: Container(
                    child: Text(
                        'DONT KNOW YOUR FINGER SIZE? \n              LETS HELP YOU!',
                        style: TextStyle(
                          color: Color(0xFFF7CCFC),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xFFF7CCFC)))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculate(String height, String width) {
    double heightt = double.parse(height);
    double widthh = double.parse(width);

    double result = heightt / widthh;
    String imagePath = " ";

    if (result > 4.5) {
      ///tall and thin
      // Image.asset(
      //   'images/oval.jpeg', // oval
      //   width: 80,
      //   height: 80,
      //   fit: BoxFit.cover,
      // );
      imagePath = 'images/oval.jpeg';
    } else if (4.5 >= result && result > 4) {
      //short and thin
      // Image.asset(
      //   'images/Marquise.jpeg',
      //   width: 80,
      //   height: 80,
      //   fit: BoxFit.cover,
      // );
      imagePath = 'images/Marquise.jpeg';
      //Marquise Cut
    } else if (result > 3.5 && result < 4) {
      // tall and chuppy
      // Image.asset(
      //   'images/emerald.jpeg',
      //   width: 80,
      //   height: 80,
      //   fit: BoxFit.cover,
      // );
      imagePath = 'images/emerald.jpeg';
      // emerald
    } else if (result < 3.5) {
      // short and chubby
      // Image.asset(
      //   'images/pear.jpeg',
      //   width: 80,
      //   height: 80,
      //   fit: BoxFit.cover,
      // );
      imagePath = 'images/pear.jpeg';
      //pear-shaped diamond.
    } else {
      //please provide a clear image
    }

    setState(() {
      selectedImagePath = imagePath; // Update the state to display the image
    });
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xFFF7CCFC),
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 8.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 70,
                          color: Color(0xFF946699),
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(color: Color(0xFF946699)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
      uploadImage();
    });
    Navigator.of(context).pop();
  }

  void uploadImage() async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    if (selectedImage == null) {
      return;
    }

    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('items')
          .child('item_${uniqueFileName}_100.jpg');

      await storageRef.putFile(selectedImage!);

      String downloadURL = await storageRef.getDownloadURL();

      print('Image uploaded successfully. Download URL: $downloadURL');

      setState(() {
        imageUrl = downloadURL;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 300,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      _image!,
                      width: 340,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      'No image available',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kourcolor1,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  void uploadimage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 380,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showImagePickerOption(context);
                  },
                  child: Container(
                    width: 340,
                    height: 300,
                    decoration: BoxDecoration(
                      /*  gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFEFEFEF), Color(0xFFD9D9D9)],
                      ), */
                      color: Color(0xFFF7CCFC),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 300,
                          height: 250,
                          child: Center(
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(
                                      _image!,
                                      width: 300,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'images/upload.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Upload a picture of your hand',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF946699),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _image != null ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Uploaded!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        20), // Add some spacing between the GestureDetector and the button
                Container(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      showImageDialog(context);
                      // String result = await HandDetectionChannel.detectHand(
                      //     imageUrl); ////////////////////////
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF7CCFC)),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF946699),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /////////////////////////////////////////////////////////
  // Future processImage(File image) async {
  //   // Convert image to grayscale
  //   var img = await ImgProc.cvtColor(
  //       await image.readAsBytes(), ImgProc.colorBGR2GRAY);

  //   // Apply GaussianBlur
  //   img = await ImgProc.gaussianBlur(img, [5, 5], 0);

  //   // Detect edges using Canny
  //   var edges = await ImgProc.canny(img, 100, 200);

  //   // Find contours
  //   List<MatOfPoint> contours = await ImgProc.findContours(
  //       edges, ImgProc.retrExternal, ImgProc.chainApproxSimple);

  //   // Assuming the largest contour is the hand
  //   double largestArea = 0;
  //   MatOfPoint? largestContour;
  //   for (var contour in contours) {
  //     double area = await ImgProc.contourArea(contour);
  //     if (area > largestArea) {
  //       largestArea = area;
  //       largestContour = contour;
  //     }
  //   }

  //   // Optionally draw contours to visualize - creating a mask to draw on
  //   var result = await ImgProc.cvtColor(edges, ImgProc.colorGRAY2BGRA);
  //   if (largestContour != null) {
  //     result = await ImgProc.drawContours(
  //         result, [largestContour], -1, [0, 255, 0, 255], 3);
  //   }

  //   setState(() {
  //     _processedImage = result;
  //   });
  // }
}
