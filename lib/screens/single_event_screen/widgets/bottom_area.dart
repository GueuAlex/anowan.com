import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/event_model.dart';
import '../../order_screen/order_screen.dart';

class BottomArea extends StatelessWidget {
  const BottomArea({
    super.key,
    required this.size,
    required this.event,
  });

  final Size size;
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (event.isPastEvent) {
      return Container(
        color: Colors.transparent,
        constraints: BoxConstraints(maxHeight: size.height * 0.0),
      );
    }
    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      //height: 100,
      constraints: BoxConstraints(maxHeight: size.height * 0.115),
      width: size.width,
      decoration: BoxDecoration(
        color: Palette.greyColor.withOpacity(0.03),
        border: Border(
          top: BorderSide(
            width: 1,
            color: Palette.separatorColor,
          ),
        ),
      ),
      child: event.free ? freeRow(ctxt: context) : noFreeRow(ctxt: context),
    );
  }

  Widget noFreeRow({required BuildContext ctxt}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small(
                    'Accessible à partir de',
                  ),
                  AppText.large(
                    '${Functions.numberFormat(event.passes![0].price.toString())} ₣',
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                elevation: WidgetStatePropertyAll(1),
                backgroundColor: WidgetStatePropertyAll(
                  Palette.appRed,
                ),
              ),
              onPressed: () => Navigator.pushNamed(
                ctxt,
                OrderScreen.routeName,
                arguments: event,
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                //width: 90,

                ///height: 45,
                child: AppText.medium(
                  'Obtenir des billets',
                  textAlign: TextAlign.center,
                  color: Palette.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container soldOut() {
    return Container(
      // lorsque l'evenement est gratuit
      decoration: BoxDecoration(
        color: Color.fromARGB(138, 255, 219, 17),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      width: double.infinity,
      child: Column(
        children: [
          AppText.medium(
            'Ventes terminées',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Palette.blackColor.withOpacity(0.8),
          ),
          //Gap(5),
          SafeArea(
            bottom: true,
            top: false,
            right: false,
            left: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppText.small(
                'Ne vous inquiétez pas, de nouveaux événements passionnants arrivent bientôt. Restez à l\'affût !',
                maxLine: 2,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w300,
                // fontSize: ,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget freeRow({required BuildContext ctxt}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          children: [
            Container(
              width: 100,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Palette.appRed.withOpacity(0.15),
                borderRadius: BorderRadius.circular(3),
              ),
              child: AppText.medium(
                'Gratuit',
                textAlign: TextAlign.center,
                color: Palette.appRed,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(25),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  elevation: WidgetStatePropertyAll(1),
                  backgroundColor: WidgetStatePropertyAll(
                    Palette.primaryColor,
                  ),
                ),
                onPressed: () => Navigator.pushNamed(
                  ctxt,
                  OrderScreen.routeName,
                  arguments: event,
                ),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  //width: 90,

                  ///height: 45,
                  child: AppText.medium(
                    'Obtenir des billets',
                    textAlign: TextAlign.center,
                    color: Palette.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
