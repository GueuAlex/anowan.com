import 'package:flutter/widgets.dart';

import '../../../config/app_text.dart';

class PassDecriptionSheet extends StatelessWidget {
  const PassDecriptionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:
            AppText.medium('Description complète de ce pass et ses avantages'),
      ),
    );
  }
}
