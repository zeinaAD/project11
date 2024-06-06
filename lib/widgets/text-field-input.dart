import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.controller,
  });

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
         //color: Colors.grey[500]?.withOpacity(0.5) ?? Colors.grey[500],
       // color: kcontentColor?.withOpacity(0.5) ?? kcontentColor,
       color: Color(0xA5FFFFFF),
          //color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                icon,
                size: 28,
                color: kourcolor1,
              ),
            ),
            hintText: hint,
            hintStyle: kBodyText3,
          ),
          style: kBodyText3,
          keyboardType: inputType,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
