import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/palette.dart';

import 'sheet_header.dart';

class OperatorSwitch extends ConsumerWidget {
  const OperatorSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Palette.separatorColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          sheetheader(
            context: context,
            text: 'Selectionner un operateur',
            hopacity: 0,
          ),
          Gap(15),
        ],
      ),
    );
  }
}
