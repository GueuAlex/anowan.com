import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../config/app_text.dart';
import '../../../../config/palette.dart';

class DialogModal extends StatelessWidget {
  const DialogModal({
    super.key,
    this.title = 'Où trouver votre code OPT ?',
    this.message =
        'Composez le #144*82# puis suivez les étapes du parcours pour obtenir votre code',
  });
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 130, minWidth: 350),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  AppText.medium(
                    title,
                    fontSize: 18,
                  ),
                  const Gap(5),
                  AppText.small(
                    textAlign: TextAlign.center,
                    message,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                //height: 45,
                decoration: BoxDecoration(
                  color: Palette.separatorColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: AppText.medium(
                    'Retour',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
