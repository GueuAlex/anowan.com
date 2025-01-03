import 'package:flutter/material.dart';

import '../../../widgets/build_icon.dart';

class HeaderWidgets extends StatelessWidget {
  const HeaderWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildIcon(
            svgPath: 'assets/icons/angle-petit-gauche.svg',
            onTap: () => Navigator.of(context).pop(),
          ),
          /*  buildIcon(
            svgPath: 'assets/icons/exclamation.svg',
            onTap: () {},
          ), */
        ],
      ),
    );
  }
}
