import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class RingOnHand extends StatefulWidget {
  @override
  _RingOnHandState createState() => _RingOnHandState();
}

class _RingOnHandState extends State<RingOnHand> {
  File? _image;
  Uint8List? ringImage;
  double ringScale = 1.0;
  double ringRotation = 0.0;
  Offset ringPosition = Offset.zero;
  Rect? cropRect;
  final picker = ImagePicker();
  Offset initialFocalPoint = Offset.zero;
  Offset initialPosition = Offset.zero;
  double initialScale = 1.0;

  Future getImage(bool isCamera) async {
    final pickedFile = await picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        loadRingImage();
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> loadRingImage() async {
    final data = await rootBundle.load('images/ringg1.png');
    setState(() {
      ringImage = data.buffer.asUint8List();
    });
  }

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

  Widget ringImageWidget() {
    if (ringImage == null) {
      return Container(); // Return an empty container if ringImage is null
    }

    return GestureDetector(
      onScaleStart: (details) {
        initialFocalPoint = details.focalPoint;
        initialPosition = ringPosition;
        initialScale = ringScale;
      },
      onScaleUpdate: (details) {
        setState(() {
          ringScale = initialScale * details.scale;
          ringRotation = details.rotation;
          final delta = details.focalPoint - initialFocalPoint;
          ringPosition = initialPosition + delta;
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..translate(ringPosition.dx, ringPosition.dy)
          ..rotateZ(ringRotation)
          ..scale(ringScale),
        child: Image.memory(
          ringImage!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Try Ring on Hand"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () => getImage(true),
          ),
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () => getImage(false),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset localPosition =
                renderBox.globalToLocal(details.globalPosition);
            updateCropRect(localPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            ringPosition = cropRect!.topLeft;
            ringScale = cropRect!.width /
                100; // Assuming the initial width is 100, adjust as necessary
            cropRect = null; // Clear cropRect after placing the ring
          });
        },
        child: Stack(
          children: [
            _image == null
                ? Center(child: Text("No image selected."))
                : PhotoView(
                    imageProvider: FileImage(_image!),
                    backgroundDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
            if (_image != null && ringImage != null) ringImageWidget(),
            if (cropRect != null)
              Positioned(
                left: cropRect!.left,
                top: cropRect!.top,
                child: Container(
                  width: cropRect!.width,
                  height: cropRect!.height,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
