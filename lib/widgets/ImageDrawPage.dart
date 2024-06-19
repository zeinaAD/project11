import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:project1/widgets/FingerDrawPainter.dart';
import 'package:image/image.dart' as img;
import 'package:project1/widgets/UserPreferences.dart';

class ImageDrawPage extends StatefulWidget {
  @override
  _ImageDrawPageState createState() => _ImageDrawPageState();
}

class _ImageDrawPageState extends State<ImageDrawPage> {
  List<Offset?> points = [];
  Rect? cropRect;
  Uint8List?
      displayedImage; // This will hold the image data for the cropped image

  void updateCropRect(Offset point) {
    if (cropRect == null) {
      cropRect = Rect.fromPoints(point, point);
    } else {
      double left = min(cropRect!.left, point.dx);
      double top = min(cropRect!.top, point.dy);
      double right = max(cropRect!.right, point.dx);
      double bottom = max(cropRect!.bottom, point.dy);
      cropRect = Rect.fromLTRB(left, top, right, bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Draw and Crop Image"),
        actions: [
          IconButton(
            icon: Icon(Icons.crop),
            onPressed: cropAndSaveImage, // Triggers cropping
          )
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset localPosition =
                renderBox.globalToLocal(details.globalPosition);
            points.add(localPosition);
            updateCropRect(localPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null); // End of drawing segment
          });
        },
        child: Stack(
          children: [
            PhotoView(
              imageProvider: AssetImage("images/hand01.jpg"),
              // imageProvider: NetworkImage(UserPreferences.getimageUrl()!),/////////////////////
            ),
            CustomPaint(
              painter: FingerDrawPainter(points),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            if (displayedImage != null)
              Center(
                child: Image.memory(displayedImage!),
              ),
          ],
        ),
      ),
    );
  }

  void cropAndSaveImage() async {
    if (cropRect != null) {
      final originalImage = await loadImage('images/hand01.jpg');
      //  final originalImage = await loadImage(UserPreferences.getimageUrl()!);/////////////
      final croppedImage = img.copyCrop(originalImage,
          x: cropRect!.left.toInt(),
          y: cropRect!.top.toInt(),
          width: cropRect!.width.toInt(),
          height: cropRect!.height.toInt());

      // Convert cropped image to a format Flutter can display
      Uint8List pngBytes = Uint8List.fromList(img.encodePng(croppedImage));
      setState(() {
       //displayedImage = pngBytes; // Set the state to display the new image
      });
    }
    print('Cropped rectangle width in pixels: ${cropRect!.width.toInt() - 7}');
    print('Cropped rectangle heightin pixels: ${cropRect!.height.toInt()}');

    const double ppi = 97.0;

    double widthIncm = (cropRect!.width.toInt() / ppi) * 2.54;
    double heightIncm = (cropRect!.height.toInt() / ppi) * 2.54;

    print('Cropped rectangle width in cm: $widthIncm');
    print('Cropped rectangle height in cm: $heightIncm');

    UserPreferences.setWidthandheight(heightIncm, widthIncm);

    print(UserPreferences.getHeight());
    print(UserPreferences.getWidth());
  }

  Future<img.Image> loadImage(String imagePath) async {
    final data = await rootBundle.load(imagePath);
    final bytes = data.buffer.asUint8List();
    return img.decodeImage(bytes)!; // Ensure this does not return null
  }
}
