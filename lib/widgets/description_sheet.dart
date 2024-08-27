import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../config/palette.dart';
import 'custom_button.dart';
import 'sheet_closer_cross.dart';

Container prestatorDescriptionSheet(
    {required String html, required BuildContext ctxt}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(ctxt).size.height * 0.6,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      children: [
        sheetCloserCross(ctxt: ctxt),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: HtmlWidget(
              html,
              textStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),
        SafeArea(
          child: CustomButton(
            color: Palette.appRed,
            width: double.infinity,
            height: 35,
            radius: 5,
            text: 'OK',
            onPress: () => Navigator.pop(ctxt),
          ),
        ),
      ],
    ),
  );
}
