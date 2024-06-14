import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/widgets/my_image_view.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  static const pickImageChannel = MethodChannel("pickImagePlatform");
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick an Image"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                try {
                  final String result = await pickImageChannel.invokeMethod('pickImage');
                  setState(() {
                    imageUrl = result;
                  });
                } on PlatformException catch (e) {
                  debugPrint("Failed to pick image: ${e.message}");
                }
              },
              child: const Text("Pick Image"),
            ),
            imageUrl.isNotEmpty
                ? SizedBox(
                    width: 400,
                    height: 400,
                    child: MyImageView (imageUrl:imageUrl),
                    //child: Image.network(imageUrl),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
