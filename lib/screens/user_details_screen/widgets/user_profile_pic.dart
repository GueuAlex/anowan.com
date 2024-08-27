import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/palette.dart';

class UserProfilePic extends StatelessWidget {
  const UserProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.separatorColor,
            border: Border.all(
              width: 0.8,
              color: const Color.fromARGB(255, 207, 207, 207),
            ),
            image: DecorationImage(
              image: AssetImage(
                'assets/images/carousel/carousel1.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: _plusButton(),
        )
      ],
    );
  }

  Container _plusButton() => Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Palette.appRed,
          shape: BoxShape.circle,
          border: Border.all(
            width: 4,
            color: Colors.white,
          ),
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.plus,
            color: Palette.separatorColor,
            size: 16,
          ),
        ),
      );
}
