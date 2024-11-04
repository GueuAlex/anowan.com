import 'package:flutter/material.dart';

import '../config/app_text.dart';

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget({
    super.key,
    this.icon,
    required this.text,
  });
  final IconData? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Couleur de l'ombre
            spreadRadius: 5, // Étendue de l'ombre
            blurRadius: 10, // Flou de l'ombre
            offset: Offset(0, 3), // Décalage de l'ombre (x, y)
          ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.white,
              size: 14,
            ),
          const SizedBox(width: 8),
          Expanded(
            child: AppText.small(
              text,
              fontSize: 11,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
