import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/palette.dart';

import '../auth/registration/registration.dart';

class IntroScrenn extends StatelessWidget {
  static String routeName = "introScreen";
  const IntroScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/images/people2.png"),
            const Spacer(flex: 3),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Anowan.com le ',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                children: [
                  WidgetSpan(
                    child: Transform.rotate(
                      angle: -0.1, // Rotation en radians
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: Palette.appRed,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'n°1',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Palette.whiteColor,
                                fontSize: 25,
                              ),
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ' \nde la gestion d\'événements',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            Gap(5),
            Text(
              "Découvrez et participez à des événements\nde manière simple et rapide.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
            const Spacer(flex: 3),
            FittedBox(
              child: TextButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        /* BottomBar.routeName, */
                        RegistrationScreen.routeName,
                        /* IntroScrenn.routeName, */
                        (route) => false,
                      ),
                  child: Row(
                    children: [
                      Text(
                        "Skip",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.8),
                            ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.8),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
