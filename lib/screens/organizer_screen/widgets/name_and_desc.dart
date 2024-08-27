import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/organizer_model.dart';
import '../../../widgets/description_sheet.dart';

class OrganisationNameAndDesc extends StatelessWidget {
  const OrganisationNameAndDesc({
    super.key,
    required this.organizer,
  });
  final OrganizerModel organizer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium(
            organizer.name,
            maxLine: 1,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 32, 32, 32),
          ),
          Gap(5),
          if (organizer.shortDescription.trim().isNotEmpty)
            _description(context),
          Gap(8),
          if (organizer.website.trim().isNotEmpty) _link(),
        ],
      ),
    );
  }

  Row _link() {
    return Row(
      children: [
        Transform.rotate(
          angle: -0.7,
          child: Icon(
            FluentIcons.link_24_regular,
            size: 28,
            color: CupertinoColors.activeBlue,
          ),
        ),
        Gap(5),
        Expanded(
          child: AppText.medium(
            organizer.website,
            color: CupertinoColors.activeBlue,
            fontSize: 16.5,
            fontWeight: FontWeight.w300,
            maxLine: 1,
            textOverflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Stack _description(BuildContext context) {
    return Stack(
      children: [
        AppText.small(
          organizer.shortDescription,
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
          maxLine: 3,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () => Functions.showSimpleBottomSheet(
              ctxt: context,
              widget: prestatorDescriptionSheet(
                html: organizer.description,
                ctxt: context,
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.9),
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                ),
              ),
              child: AppText.medium(
                'Voir plus',
                color: Palette.appRed,
              ),
            ),
          ),
        )
      ],
    );
  }
}
