import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../config/app_text.dart';

class Alert1 extends StatelessWidget {
  const Alert1({
    super.key,
    required this.alert,
    required this.color,
    required this.icon,
  });
  final String alert;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            //FluentIcons.megaphone_24_filled,
            icon,
            color: color,
            size: 16,
          ),
          Gap(8),
          AppText.medium(
            alert,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ],
      ),
    );
  }
}
