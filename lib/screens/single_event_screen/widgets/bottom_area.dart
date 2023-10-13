import 'package:flutter/material.dart';

import '../../../config/app_text.dart';

class BottomArea extends StatelessWidget {
  const BottomArea({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      height: 100,
      width: size.width,
      color: Colors.amber,
      child: SafeArea(
        child: Center(child: AppText.medium('achat de billets ici')),
      ),
    );
  }
}
