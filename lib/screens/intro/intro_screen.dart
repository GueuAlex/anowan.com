import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:izibillet/widgets/custom_button.dart';

import '../../config/palette.dart';
import '../../config/preferences.dart';
import '../../widgets/bottom_bar.dart';
import '../auth/auth_screen.dart';

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
                text: 'Izibillet le ',
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
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*  Container(
                      //color: Colors.amber,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        overlayColor: WidgetStatePropertyAll(Colors.transparent),
                        onTap: () => _redirect(
                          ctxt: context,
                          route: BottomBar.routeName,
                        ),
                        child: Text(
                          'Obtenir un aperçu',
                          style: TextStyle(
                            color: const Color.fromARGB(221, 35, 35, 35),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ), */

                    /*  Container(
                      // color: Colors.amber,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        overlayColor: WidgetStatePropertyAll(Colors.transparent),
                        onTap: () => _redirect(
                          ctxt: context,
                          route: AuthScreen.routeName,
                        ),
                        child: Text(
                          'S\'authentifier',
                          style: TextStyle(
                            color: const Color.fromARGB(221, 35, 35, 35),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ), */
                    // const Gap(20),
                    CustomButton(
                      color: Palette.separatorColor,
                      width: double.infinity,
                      //fontsize: 11,
                      //isSetting: true,
                      textColor: const Color.fromARGB(255, 43, 43, 43),
                      height: 40,
                      radius: 5,
                      text: 'Obtenir un aperçu',
                      onPress: () => _redirect(
                        ctxt: context,
                        route: BottomBar.routeName,
                      ),
                    ),
                    const Gap(8.0),
                    CustomButton(
                      color: Palette.appRed,
                      width: double.infinity,
                      height: 40,
                      radius: 5,
                      text: 'S\'authentifier',
                      onPress: () => _redirect(
                        ctxt: context,
                        route: AuthScreen.routeName,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(45),
          ],
        ),
      ),
    );
  }

  void _redirect({required String route, required BuildContext ctxt}) {
    EasyLoading.show();
    Preferences prefs = Preferences();
    prefs.setBool('showIntro', false).whenComplete(() {
      EasyLoading.dismiss();

      Navigator.pushReplacementNamed(ctxt, route);
    });
  }
}
