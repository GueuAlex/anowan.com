import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/functions.dart';
import 'package:ticketwave/widgets/horizontal_separator.dart';
import 'package:ticketwave/widgets/sheet_closer_cross.dart';

import '../../../config/palette.dart';
import '../../../model/prestator_model.dart';
import '../../../widgets/build_link.dart';

class MoreContact extends StatelessWidget {
  const MoreContact({
    super.key,
    required this.prestator,
  });
  final PrestatorMdel prestator;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Functions.showSimpleBottomSheet(
          ctxt: context,
          widget: _moreContactSheet(prestator: prestator, ctxt: context)),
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Palette.appRed,
        ),
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }

  Container _moreContactSheet(
      {required BuildContext ctxt, required PrestatorMdel prestator}) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(ctxt).size.height * 0.35,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            sheetCloserCross(ctxt: ctxt, text: 'Liens'),
            horizontalSeparator(
              width: MediaQuery.of(ctxt).size.width - 200,
              vpadding: 8,
              height: 0.8,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  /*  _link(
                    svgPath: 'assets/icons/a.svg',
                    text: 'E-mail',
                    subText:
                        'Laissez un message à l\'adresse example@example.com',
                    onTap: () {},
                  ),
                  */
                  Gap(18),
                  link(
                    svgPath: 'assets/icons/global-line.svg',
                    text: 'Site Web',
                    subText: 'Vistez notre site pour plus de détails',
                    onTap: () {},
                  ),
                  Gap(10),
                  link(
                    svgPath: 'assets/icons/facebook-line.svg',
                    text: 'Facebook',
                    subText: 'Voir plus de réalisations sur Facebook',
                    onTap: () {},
                  ),
                  Gap(10),
                  link(
                    svgPath: 'assets/icons/instagram-line.svg',
                    text: 'Instagram',
                    subText: 'Vous pouvez nous suivre sur Instagram',
                    onTap: () {},
                  ),
                  Gap(10),
                  link(
                    svgPath: 'assets/icons/linkedin-fill.svg',
                    text: 'LinkedIn',
                    subText: 'Consultez notre page sur LinkedIn',
                    onTap: () {},
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
