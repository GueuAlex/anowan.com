import 'package:flutter/widgets.dart';

import '../config/palette.dart';

Container customDiveder() => Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Palette.separatorColor, width: 0.8),
        ),
      ),
    );
