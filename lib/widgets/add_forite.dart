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
        color: Palette.blackColor.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          CupertinoIcons.bookmark,
          color: Palette.whiteColor,
          size: 20,
        ),
      ),
    );
  }
}
