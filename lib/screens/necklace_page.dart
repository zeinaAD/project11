import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NecklacePage extends StatefulWidget {
  const NecklacePage({super.key});

  @override
  State<NecklacePage> createState() => _NecklacePageState();
}

class _NecklacePageState extends State<NecklacePage> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider')),
      body: Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}
