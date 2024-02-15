import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../config/app_text.dart';

class Alert1 extends StatelessWidget {
  const Alert1({super.key, required this.alert});
  final String alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(73, 61, 118, 204),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            FluentIcons.megaphone_24_filled,
            color: Color.fromARGB(255, 61, 118, 204),
            size: 16,
          ),
          Gap(8),
          AppText.medium(
            alert,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
