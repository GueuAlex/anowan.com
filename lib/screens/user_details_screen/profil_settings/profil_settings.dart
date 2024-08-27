import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';
import 'package:ticketwave/screens/user_details_screen/widgets/user_profile_pic.dart';

class ProfilSettings extends StatelessWidget {
  static String routeName = 'profilSettings';
  const ProfilSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scafoldColor,
      appBar: AppBar(
        elevation: 0.5,
        title: AppText.medium('Modifier le profile'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // profile picture and location
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        width: 0.8,
                        color: Palette.separatorColor,
                      ),
                    )),
                child: Column(
                  children: [
                    UserProfilePic(),
                    Gap(1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.black54,
                          size: 18,
                        ),
                        Gap(5),
                        AppText.medium(
                          'Abidjan, Côte d\'Ivoire',
                          fontWeight: FontWeight.w400,
                        ),
                        Gap(5),
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {},
                          child: AppText.medium(
                            'Changer',
                            color: Palette.appRed,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //
              //account informations
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: AppText.medium('Mon compte'),
                  ),
                  _editingRoute(
                    icon: FluentIcons.person_24_regular,
                    title: 'Informatios sur le compte',
                    onTap: () {},
                  ),
                ],
              ),
              // user about
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: AppText.medium('Á propos de moi'),
                  ),
                  _editingRoute(
                    icon: FluentIcons.rocket_24_regular,
                    title: 'Parcours',
                    onTap: () {},
                  ),
                  _editingRoute(
                    borderTWidth: 0,
                    icon: FluentIcons.book_24_regular,
                    title: 'Biographie',
                    onTap: () {},
                  ),
                  _editingRoute(
                    borderTWidth: 0,
                    isTextBtn: true,
                    icon: FluentIcons.heart_24_regular,
                    title: 'Centres d\'intérêt',
                    onTap: () {},
                  ),
                ],
              ),
              //
              // confidentialité
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: AppText.medium('Confidentialité'),
                  ),
                  _buildPrivacy(
                    title: 'Rendre visible ma photo de profil',
                    subTitle:
                        'Permet aux autres participants de voir votre photo de profil sur les événements auxquels vous assistez.',
                    onChanged: (state) {},
                  ),
                  _buildPrivacy(
                    borderTWidth: 0,
                    title: 'Avertir mes contacts de ma participation',
                    subTitle:
                        'Envoyez une notification à vos contacts via SMS ou WhatsApp lorsque vous participez a un événement.',
                    onChanged: (state) {},
                  ),
                  // suggere également un autre type de privacy qui peut intéressant ici
                  _editingRoute(
                    borderTWidth: 0,
                    isTextBtn: true,
                    icon: FluentIcons.contact_card_24_regular,
                    title: 'Ma liste de contacts à notifier',
                    onTap: () {},
                  ),
                  _buildPrivacy(
                    borderTWidth: 0,
                    title: 'Partager ma position',
                    subTitle: // écire le subTitle precise que le partage de position permet a l'app de proposé des events et que les autre users ne voient la position
                        'En partageant votre position, vous permeteez à l\'application de vous proposer des événements proches de vous. Votre position ne sera pas visible par les autres utilisateurs.',
                    onChanged: (state) {},
                  ),
                ],
              ),

              //whtie space
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPrivacy({
    required String title,
    required String subTitle,
    double borderTWidth = 0.8,
    double borderBWidth = 0.8,
    required void Function(bool)? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Palette.separatorColor,
            width: borderBWidth,
          ),
          top: BorderSide(
            width: borderTWidth,
            color: Palette.separatorColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.medium(
                  title,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w400,
                ),
                AppText.small(
                  subTitle,
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                )
              ],
            ),
          ),
          Gap(5),
          Switch.adaptive(
            value: true,
            onChanged: onChanged,
            activeColor: Palette.appRed,
          )
        ],
      ),
    );
  }

  Container _editingRoute({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    double borderTWidth = 0.8,
    double borderBWidth = 0.8,
    bool isTextBtn = false,
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
            Icon(icon),
            Gap(5),
            Expanded(
              child: AppText.medium(
                title,
                fontSize: 16.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (!isTextBtn)
              Icon(
                CupertinoIcons.chevron_right,
                size: 16,
                color: Colors.black54,
              )
            else
              AppText.medium(
                'Modifier',
                color: Palette.appRed,
                fontWeight: FontWeight.w700,
              )
          ],
        ),
      ),
    );
  }
}
