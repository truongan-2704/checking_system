import 'package:checking_system/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TextDesign extends StatelessWidget {
  const TextDesign({
    Key? key,
    required this.text,
    this.color,
    required this.size,
    required this.fontWeight,
    this.textAlign,
  }) : super(key: key);

  final String text;
  final double size;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.primary1,
        fontSize: size,
        fontFamily: "Roboto",
        fontWeight: fontWeight,
      ),
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
