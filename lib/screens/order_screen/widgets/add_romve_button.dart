import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
    this.incoColor = Colors.grey,
  });
  final Color color;
  final Color incoColor;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Icon(
            icon,
            color: incoColor,
          ),
        ),
      ),
    );
  }
}
