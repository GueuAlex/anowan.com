import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/app_text.dart';

Widget actionTile(
    {required Size size,
    required VoidCallback onTap,
    required String title,
    required String subtitle,
    required String asset}) {
  return ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.all(0),
    leading: Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        //color: Colors.amber,
        image: DecorationImage(
          image: AssetImage(asset),
        ),
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: AppText.medium(
        title,
        fontSize: size.width * 0.042,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 20, 24, 25),
      ),
    ),
    subtitle: AppText.medium(
      subtitle,
      fontWeight: FontWeight.w300,
      fontSize: 12,
    ),
    trailing: Icon(
      CupertinoIcons.chevron_right,
      size: 14,
    ),
  );
}
