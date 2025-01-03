import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../intro/intro_screen.dart';

class AppSettingsScreen extends StatelessWidget {
  static const routeName = 'app_settings_screen';
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.separatorColor,
      appBar: AppBar(
        elevation: 0.5,
        title: AppText.medium('Paramètres'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: AppText.medium(
                'PREFERENCES',
                fontWeight: FontWeight.w500,
              ),
            ),
            // preferences
            _editingRoute(
              title: 'Notification Push',
              satut: 'Activé',
              onTap: () {},
            ),
            _editingRoute(
              borderTWidth: 0,
              title: 'Notification par e-mail',
              satut: 'Désactivé',
              onTap: () {},
            ),
            _editingRoute(
              title: 'Copier les événements dans le calendrier',
              //satut: 'Activé',
              borderTWidth: 0,
              onTap: () {},
            ),
            // Affiliate
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: AppText.medium(
                'PARTENARIAT',
                fontWeight: FontWeight.w500,
              ),
            ),
            _editingRoute(
              title: 'Devenir organisateur',
              //satut: 'Activé',
              onTap: () {},
            ),
            _editingRoute(
              title: 'Devenir prestataire',
              //satut: 'Activé',
              borderTWidth: 0,
              onTap: () {},
            ),
            // Support
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: AppText.medium(
                'SUPPORT',
                fontWeight: FontWeight.w500,
              ),
            ),
            _editingRoute(
              title: 'Á propos de Anowan.com',
              //satut: 'Activé',

              onTap: () {},
            ),
            _editingRoute(
              title: 'Obtenir de l\'aide',
              //satut: 'Activé',
              borderTWidth: 0,
              showChevron: false,
              onTap: () {},
            ),
            _editingRoute(
              title: 'Donnez-nous votre avis',
              //satut: 'Activé',
              borderTWidth: 0,
              showChevron: false,
              onTap: () {},
            ),
            _editingRoute(
              title: 'Évaluer l\'application',
              //satut: 'Activé',
              borderTWidth: 0,
              showChevron: false,
              onTap: () {},
            ),
            Gap(33),
            _lougoutRoute(
              onTap: () async {
                EasyLoading.show();
                await Functions.setLoggedState(isLogged: false);
                await Future.delayed(const Duration(seconds: 5));
                EasyLoading.dismiss();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  IntroScrenn.routeName,
                  (route) => false,
                );
              },
              title: 'Déconnexion',
              color: Color.fromARGB(255, 9, 126, 136),
            ),
            Gap(33),
            _lougoutRoute(
              onTap: () {},
              title:
                  'Supprimer le compte et les données personnelles utilisateur',
              color: Palette.appRed,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: AppText.small(
                'Anowan.com femra définitivement votre compte et et effacera toutes vos informations personnelles.',
                fontSize: 13.5,
                fontWeight: FontWeight.w300,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo-text-no-bg.png',
                    height: 30,
                    width: 70,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'V.2024.2.0.1 - ©2024 anowan.com\nUn produit de ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                        fontSize: 11.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'DIGIFAZ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _lougoutRoute({
    required VoidCallback onTap,
    required String title,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 0.8,
              color: Palette.separatorColor,
            ),
            bottom: BorderSide(
              width: 0.8,
              color: Palette.separatorColor,
            ),
          )),
      child: InkWell(
        onTap: onTap,
        child: AppText.medium(
          title,
          fontSize: 16.5,
          fontWeight: FontWeight.w300,
          color: color,
          textOverflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Container _editingRoute({
    required String title,
    required VoidCallback onTap,
    double borderTWidth = 0.8,
    double borderBWidth = 0.8,
    bool showChevron = true,
    String? satut,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: borderTWidth,
              color: Palette.separatorColor,
            ),
            bottom: BorderSide(
              width: borderBWidth,
              color: Palette.separatorColor,
            ),
          )),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            /*  Icon(icon),
            Gap(5), */
            Expanded(
              child: AppText.medium(
                title,
                fontSize: 16.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            AppText.medium(
              satut ?? '',
              //fontSize: 13.5,
              fontWeight: FontWeight.w300,
            ),
            showChevron
                ? Icon(
                    CupertinoIcons.chevron_right,
                    size: 16,
                    color: Colors.black54,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
