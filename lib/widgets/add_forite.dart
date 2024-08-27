import 'package:flutter/cupertino.dart';

import '../config/palette.dart';

class AddForiteButton extends StatelessWidget {
  const AddForiteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Palette.whiteColor.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          CupertinoIcons.bookmark,
          color: Palette.blackColor,
          size: 20,
        ),
      ),
    );
  }
}
