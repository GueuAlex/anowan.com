import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';

class AddCoverView extends StatelessWidget {
  const AddCoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        //alignment: Alignment.center,

        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.camera,
              color: Colors.white,
              size: 22,
            ),
            const Gap(8),
            AppText.medium(
              'Ajouter une de couverture',
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }
}
