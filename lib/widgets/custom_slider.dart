import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  String image;
  String title;
  TextStyle titleStyle;
  String text;
  TextStyle textStyle;

  CustomSlider({super.key, required this.image, required this.title, required this.text, required this.titleStyle, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Image.asset(
          image,
          width: 300,
          height: 250,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
              title,
              textAlign: TextAlign.center,
              style: titleStyle
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle
          ),
        ),
      ],
    );
  }
}