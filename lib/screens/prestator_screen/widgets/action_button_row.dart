import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../model/prestator_model.dart';
import '../../../widgets/vertical_separator.dart';
import 'comments_view.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({
    super.key,
    required this.prestator,
  });
  final PrestatorMdel prestator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _rateButton(
                onTap: () => Functions.showSimpleBottomSheet(
                  ctxt: context,
                  widget: CommentsView(),
                ),
              ),
              Gap(8),
              _button(onTap: () {}),
              Gap(8),
              if (prestator.address != null)
                _button(
                    onTap: () {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: '${prestator.address}',
                      );
                      Functions.launchUri2(url: emailLaunchUri);
                    },
                    isShare: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rateButton({required VoidCallback onTap}) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 140, 140, 140).withOpacity(0.14),
          borderRadius: BorderRadius.circular(3.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.medium(
              '4.5 ',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            Gap(3),
            SvgPicture.asset(
              'assets/icons/star.svg',
              width: 16,
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 227, 175, 16), BlendMode.srcIn),
            ),
            verticalSeparator(height: 10),
            AppText.medium(
              'nous noté',
              fontWeight: FontWeight.w700,
            )
          ],
        ),
      ),
    );
  }

  Widget _button({required VoidCallback onTap, bool isShare = true}) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 140, 140, 140).withOpacity(0.14),
          borderRadius: BorderRadius.circular(3.5),
        ),
        child: !isShare
            ? SvgPicture.asset(
                'assets/icons/a.svg',
                width: 20,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 9, 9, 9), BlendMode.srcIn),
              )
            : AppText.medium(
                'Partager ce profile',
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }
}
