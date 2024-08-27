import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../constants/tags.dart';
import '../../../providers/providers.dart';
import '../../../widgets/tags_builder.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CentreInteret extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTags = ref.watch(tagsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.medium(
              'Vos centres d\'intérêt',
              fontSize: (MediaQuery.of(context).size.width * 0.042),
              fontWeight: FontWeight.w500,
            ),
            if (tags.isNotEmpty)
              TextButton(
                onPressed: () {},
                child: AppText.medium(
                  'Modifier',
                  fontSize: (MediaQuery.of(context).size.width * 0.040),
                  fontWeight: FontWeight.w700,
                  color: Palette.appRed,
                ),
              ),
          ],
        ),
        const Gap(10),
        if (tags.isNotEmpty)
          tagsBuilder(
            tags: tags.sublist(0, 9),
            selectedTags: selectedTags,
            ref: ref,
          )
        else
          _dottedBorder(MediaQuery.of(context).size)
      ],
    );
  }

  DottedBorder _dottedBorder(Size size) {
    return DottedBorder(
      padding: const EdgeInsets.all(10),
      strokeWidth: 1,
      //borderPadding: EdgeInsets.all(5),
      radius: const Radius.circular(5),
      color: Colors.grey,
      borderType: BorderType.RRect,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AppText.medium(
              'Persoonalisez vos recommandations d\'évènements en fonction de vos intérêts',
              fontWeight: FontWeight.w300,
              fontSize: size.width * 0.042,
            ),
          ),
          Gap(10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 0.8, color: Palette.appRed),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AppText.medium(
              '+ Ajouter',
              color: Palette.appRed,
              fontSize: 15,
              //fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
