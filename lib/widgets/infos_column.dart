import 'package:flutter/material.dart';

import '../../../config/app_text.dart';

class InfosColumn extends StatelessWidget {
  const InfosColumn({
    super.key,
    this.height = 45,
    this.width = double.infinity,
    required this.label,
    //required this.text,
    required this.widget,
    this.opacity = 0,
  });
  final double height;
  final double width;
  final String label;
  //final String text;
  final Widget widget;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(opacity),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.small(
            label,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          widget,
        ],
      ),
    );
  }
}
