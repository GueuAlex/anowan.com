import 'package:flutter/material.dart';

class AppText extends Text {
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;
  final double? letterSpacing;
  final double fontSize;

  AppText.small(
    String data, {
    Key? key,
    this.letterSpacing = 0,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    TextAlign? textAlign = TextAlign.left,
    int? maxLine,
    TextOverflow? textOverflow,
    this.height,
    this.fontSize = 12,
  }) : super(
          data,
          key: key,
          textAlign: textAlign,
          maxLines: maxLine,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            height: height,
            fontWeight: fontWeight,
            overflow: textOverflow,
            letterSpacing: letterSpacing,
          ),
        );

  AppText.medium(
    String data, {
    Key? key,
    this.letterSpacing = 0,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
    TextAlign? textAlign = TextAlign.left,
    int? maxLine,
    TextOverflow? textOverflow,
    this.height,
    this.fontSize = 14,
  }) : super(
          data,
          key: key,
          textAlign: textAlign,
          maxLines: maxLine,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            height: height,
            fontWeight: fontWeight,
            overflow: textOverflow,
            letterSpacing: letterSpacing,
          ),
        );

  AppText.large(
    String data, {
    Key? key,
    this.letterSpacing = 0,
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold,
    TextAlign? textAlign = TextAlign.center,
    int? maxLine,
    TextOverflow? textOverflow,
    this.height,
    this.fontSize = 24,
  }) : super(
          data,
          key: key,
          textAlign: textAlign,
          maxLines: maxLine,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            height: height,
            fontWeight: fontWeight,
            overflow: textOverflow,
            letterSpacing: letterSpacing,
          ),
        );
}
