import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/app_text.dart';
import '../../config/palette.dart';
import '../../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  static final String routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 45,
        leading: InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(62, 158, 158, 158),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.xmark,
                size: 18,
                color: const Color.fromARGB(255, 70, 70, 70),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Bienvenue sur Izibillet',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Toggle buttons (Weekly / Annual)
                  SizedBox(
                    width: 250,
                    height: 67,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 250),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Palette.separatorColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: AppText.medium(
                                    'Événements',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: AppText.medium(
                                    'Billets',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 15,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Palette.appRed,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '25% OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Image
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg'), // Remplacer par l'url de ton image
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // applique un gradiant transparent vers le haut et noir vers le bas
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(0.65),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: 'Izibillet\n ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'le ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Transform.rotate(
                                      angle: -0.1, // Rotation en radians
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          color: Palette.appRed,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          'top 1',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' de l\'événementiel',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 42,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                              color: Palette.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/ico.png'),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Plan details
                  Gap(15),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Avec l\'app Izibillet\nProfiter des avantages exclusives.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Benefits
                  ListTile(
                    leading: Icon(FluentIcons.ticket_diagonal_24_regular),
                    title: Text('Billets facile d\'accès'),
                    subtitle: Text(
                      'Toutes vos billets sont disponibles en un clic et facilement accessibles.',
                    ),
                  ),
                  ListTile(
                    leading: Icon(FluentIcons.money_calculator_24_regular),
                    title: Text('25% de remise'),
                    subtitle: Text(
                        'Profitez d\'une remise de 25% sur prémier achat ded ticket'),
                  ),
                  ListTile(
                    leading: Icon(FluentIcons.key_24_regular),
                    title: Text('Paiements sécurisé'),
                    subtitle: Text(
                      'Payez vos billets en toute sécurité et en un clic depuis chez vous.',
                    ),
                  ),

                  // Try free section
                  Gap(45),
                  CustomButton(
                    color: Palette.appRed,
                    width: double.infinity,
                    height: 40,
                    radius: 5,
                    text: 'Profiter maintenant',
                    onPress: () => Navigator.pop(context),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
