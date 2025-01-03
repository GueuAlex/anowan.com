import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../model/prestator_model.dart';
import '../../widgets/build_icon.dart';
import 'widgets/prestator_header.dart';

class PrestatorScreen extends StatelessWidget {
  static const routeName = 'prestatorScreen';
  const PrestatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prestator =
        ModalRoute.of(context)!.settings.arguments as PrestatorMdel;
    return Scaffold(
      backgroundColor: Palette.scafoldColor,
      body: Stack(
        children: [
          PrestatorHeader(prestator: prestator),
          _actionButtonRow(context: context),
        ],
      ),
    );
  }

  Container _actionButtonRow({required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: SafeArea(
        child: Row(
          children: [
            buildIcon(
              svgPath: 'assets/icons/angle-petit-gauche.svg',
              onTap: () => Navigator.of(context).pop(),
              bgOpacity: 0.7,
            ),
            Expanded(
              child: Row(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
