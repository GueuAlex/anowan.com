import 'package:flutter/widgets.dart';

class HeightSpacer extends StatelessWidget {
  final double myHeight;
  const HeightSpacer({Key? key, required this.myHeight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: myHeight,
    );
  }
}
