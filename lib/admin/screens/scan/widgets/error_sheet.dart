import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../../../../config/functions.dart';
import '../../../../config/palette.dart';

Future<void> error({required BuildContext context}) async {
  ///////////////////////
  ///sinon on fait vibrer le device
  ///et on afficher un message d'erreur
  final _size = MediaQuery.of(context).size;
  Vibration.vibrate(duration: 200);
  return await Functions.showSimpleBottomSheet(
    ctxt: context,
    widget: Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: Palette.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Functions.widget404(
        size: _size,
        ctxt: context,
      ),
    ),
  );
}
