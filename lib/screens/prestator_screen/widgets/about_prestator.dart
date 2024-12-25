import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/prestator_model.dart';
import '../../../widgets/description_sheet.dart';

class AboutPrestator extends StatelessWidget {
  const AboutPrestator({
    super.key,
    required this.prestator,
  });
  final PrestatorMdel prestator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.large(
                'À propos de nous',
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.black87,
              ),
              InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                highlightColor: Colors.transparent,
                onTap: () => Functions.showSimpleBottomSheet(
                  ctxt: context,
                  widget: prestatorDescriptionSheet(
                    html: prestator.description ?? '',
                    ctxt: context,
                  ),
                ),
                child: AppText.medium(
                  'Voir plus',
                  fontSize: (MediaQuery.of(context).size.width * 0.035),
                  fontWeight: FontWeight.w700,
                  color: Palette.appRed,
                ),
              )
            ],
          ),
          AppText.medium(
            'Nous prestons dans les domaines tels que',
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          Gap(5),
          _pretatorTags()
        ],
      ),
    );
  }

  Wrap _pretatorTags() => Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: prestator.tags
            .map(
              (tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Palette.appRed,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: AppText.small(
                  tag,
                  color: Colors.white,
                ),
              ),
            )
            .toList(),
      );
}
