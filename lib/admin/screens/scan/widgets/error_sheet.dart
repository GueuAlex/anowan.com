import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../../../../config/functions.dart';
import '../../../../config/palette.dart';

void error({required Size size, required BuildContext context}) {
  ///////////////////////
  ///sinon on fait vibrer le device
  ///et on afficher un message d'erreur
  ///
  Vibration.vibrate(duration: 200);
  Functions.showSimpleBottomSheet(
    ctxt: context,
    widget: Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: Palette.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Functions.widget404(
        size: size,
        ctxt: context,
      ),
    ),
  );
}
