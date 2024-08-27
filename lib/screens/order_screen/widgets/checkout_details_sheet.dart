import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/widgets/custom_button.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class CheckoutDetailsSheet extends StatelessWidget {
  const CheckoutDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 247, 247),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Palette.separatorColor,
                  width: 0.8,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.rotate(
                      angle: -0.8,
                      child: SvgPicture.asset(
                        'assets/icons/echanger.svg',
                        width: 16,
                        height: 16,
                      ),
                    ),
                    Gap(3),
                    AppText.medium(
                      'Mobile Money',
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ],
                ),
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.zero,
                    ),
                  ),
                  child: AppText.medium(
                    'Annuler',
                    fontWeight: FontWeight.w700,
                    color: Palette.appRed,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  checkoutRowInfos(
                    isAsset: true,
                    title: 'assets/images/om1.png',
                    columnTitle: 'NUMÉRO DE PAIEMENT',
                    columnValue: '+33 600 00 00 00',
                  ),
                  checkoutRowInfos(
                    title: 'ACHAT',
                    columnTitle: 'VOTRE COMMANDE',
                    columnValue:
                        '(1) tiket étudiant - (4) tickets standard - (3) tickets VIP',
                  ),
                  checkoutRowInfos(
                    title: 'CONTACT',
                    columnTitle: 'CUSTOMER FULL NAME',
                    columnValue: 'email@email.com',
                  ),
                  checkoutRowInfos(
                    title: 'TOTAL',
                    columnTitle: '453 775 ₣',
                    columnValue: '',
                  ),
                ],
              ),
            ),
          ),
          Gap(20),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: CustomButton(
                color: Palette.appRed,
                width: double.infinity,
                height: 40,
                radius: 5,
                text: 'ok',
                onPress: () => print('pay'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container checkoutRowInfos({
    required title,
    required String columnTitle,
    required String columnValue,
    bool isAsset = false,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Palette.separatorColor, width: 0.8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              child: Container(
                padding: const EdgeInsets.all(6),
                constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
                child: isAsset
                    ? Image.asset(title)
                    : AppText.medium(
                        title,
                        color: Color.fromARGB(255, 137, 141, 150),
                        fontWeight: FontWeight.w700,
                      ),
              ),
            ),
            Expanded(
              child: columnValue.trim().isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          columnTitle,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 137, 141, 150),
                          fontSize: 14,
                          textAlign: TextAlign.right,
                        ),
                        AppText.small(
                          columnValue,
                          color: Color.fromARGB(255, 62, 65, 71),
                          fontSize: 14,
                        )
                      ],
                    )
                  : AppText.medium(
                      columnTitle,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      textAlign: TextAlign.left,
                      color: Color.fromARGB(255, 137, 141, 150),
                    ),
            ),
            SizedBox(
              width: 30,
              child: Icon(
                CupertinoIcons.chevron_right,
                color: Color.fromARGB(255, 125, 124, 124),
                size: 16,
              ),
            ),
          ],
        ),
      );
}
