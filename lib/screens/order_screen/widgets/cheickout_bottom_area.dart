import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../widgets/alert_1.dart';
import '../../../widgets/custom_button.dart';

class CheckBottomArea extends StatelessWidget {
  const CheckBottomArea({
    super.key,
    required this.size,
    required this.onPress,
  });

  final Size size;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      height: 150,
      width: size.width,
      decoration: BoxDecoration(
        color: Palette.greyColor.withOpacity(0.03),
        border: Border(
          top: BorderSide(
            width: 2,
            color: Palette.greyColor.withOpacity(0.2),
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Alert1(alert: 'Bientôt épuisé !'),
                  //Gap(15),

                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    //width: 150,
                    child: AppText.medium('2000 FCFA'),
                  ),
                ],
              ),
              Gap(8),
              CustomButton(
                  color: Palette.primaryColor,
                  width: double.infinity,
                  height: 35,
                  radius: 5,
                  text: 'Commander',
                  onPress: /* () => Navigator.pushNamed(
                  context,
                  CheckoutScreen.routeName,
                ), */
                      onPress),
            ],
          ),
        ),
      ),
    );
  }
}
