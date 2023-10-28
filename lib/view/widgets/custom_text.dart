import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final Alignment? alignment;
  final int? maxLines;
  final double? height;
  const CustomText(
      {this.text = '',
      //علشان لو مدتش قيمه يخليها كده
      this.fontSize = 16,
      this.color = Colors.black,
      this.alignment,
      this.maxLines,
      this.height = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: this.alignment,
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: fontSize, height: height),
        maxLines: maxLines,
      ),
    );
  }
}
