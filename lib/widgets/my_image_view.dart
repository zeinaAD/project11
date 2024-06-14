import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const myImageView = "MyImageView";

class MyImageView extends StatefulWidget {
  final String imageUrl;

  MyImageView({required this.imageUrl, super.key});

  @override
  _MyImageViewState createState() => _MyImageViewState();
}

class _MyImageViewState extends State<MyImageView> {
  late Map<String, dynamic> creationParams = <String, dynamic>{};
  late Key _key;

  @override
  void initState() {
    super.initState();
    _key = UniqueKey();
    creationParams["imageUrl"] = widget.imageUrl;
  }

  @override
  void didUpdateWidget(covariant MyImageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      creationParams["imageUrl"] = widget.imageUrl;
      _key = UniqueKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AndroidView(
            viewType: myImageView,
            key: _key,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          )
        : UiKitView(
            viewType: myImageView,
            key: _key,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          );
  }
}
