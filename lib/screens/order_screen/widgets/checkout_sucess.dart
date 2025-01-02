import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../providers/checkout_state.provider.dart';
import '../../../widgets/all_sheet_header.dart';
import '../../../widgets/custom_button.dart';

class CheckoutSucces extends ConsumerWidget {
  const CheckoutSucces({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            //height: size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const AllSheetHeader(),
                  const Gap(20),
                  DottedBorder(
                    color: Colors.green,
                    //radius: Radius.circular(10),
                    borderType: BorderType.Circle,
                    //strokeCap: StrokeCap.square,
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.3),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/en-attente.svg',
                        colorFilter: ColorFilter.mode(
                          Colors.green,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  AppText.large(
                    'Transaction en attente',
                    fontSize: 20,
                  ),
                  const Gap(5),
                  AppText.small(
                    textAlign: TextAlign.center,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    'Votre commande à bien été prise en compte. Une fois la transaction confirmé vos billets seront debloqués et vous recevrez un email de confirmation.',
                  ),
                  const Gap(25),
                  CustomButton(
                    color: Palette.appRed,
                    width: double.infinity,
                    height: 40,
                    isSetting: true,
                    fontsize: 14,
                    radius: 5,
                    text: 'Fermer',
                    onPress: () {
                      Navigator.pop(context);
                      ref.read(checkoutState.notifier).state = false;
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
