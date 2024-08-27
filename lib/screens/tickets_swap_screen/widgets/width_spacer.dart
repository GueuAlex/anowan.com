import 'package:flutter/widgets.dart';

class WidthSpacer extends StatelessWidget {
  final double myWidth;
  const WidthSpacer({Key? key, required this.myWidth}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: myWidth,
    );
  }
}
