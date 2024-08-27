import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';

import '../../widgets/build_icon.dart';
import '../../widgets/counter.dart';
import '../../widgets/vertical_separator.dart';
import 'profil_settings/profil_settings.dart';
import 'settings/app_settings_screen.dart';
import 'widgets/centre_interet_2.dart';
import 'widgets/user_profile_pic.dart';

class UserDetailsScreen extends StatelessWidget {
  static const routeName = 'userDetailsScreen';
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Change the status bar color

    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      /* 'assets/images/anowan-placeholder.png' */ 'assets/images/carousel/carousel1.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    //alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_addCoverView()],
                    ), // For better performance
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: _topIconsContainer(context: context),
          ),
          _userDetails()
        ],
      ),
    );
  }

  Widget _addCoverView() {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        //alignment: Alignment.center,

        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.camera,
              color: Colors.white,
              size: 22,
            ),
            Gap(8),
            AppText.medium(
              'Ajouter une de couverture',
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }

  DraggableScrollableSheet _userDetails() {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.38,
      maxChildSize: 0.7,
      builder: (context, controller) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            color: Colors.white,
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            controller: controller,
            itemCount: 1,
            itemBuilder: (context, index) {
              return SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(5),
                      _sheetCloserBar(),
                      Gap(15),
                      _userPicAndNames(),
                      Gap(15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          counter(count: 11),
                          verticalSeparator(),
                          counter(count: 8, text: 'Centre d\'intérêt'),
                          verticalSeparator(),
                          counter(count: 5, text: 'Évenements à venir'),
                        ],
                      ),
                      Gap(15),
                      _inviteFriends(),
                      Gap(15),
                      _about(),
                      Gap(15),
                      CentreInteret2(),
                      Gap(15),
                      _organisateur(),
                      Gap(50),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  SizedBox _organisateur() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.large(
            'Organisateur',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
          AppText.medium(
            'Les organisateurs que vous suivez apparaissent ici',
            fontSize: 14,
            color: Colors.black54,
          ),
          Gap(10),
          _organizerRow(
              assets: 'assets/images/lunch.jpg',
              name: 'Noblesse Sweetness & Food',
              followers: '45k',
              events: '+99 événements'),
          Gap(8),
          _organizerRow(
              assets: 'assets/images/expert.jpeg',
              name: 'Expert consultant',
              followers: '250k',
              events: '47 événements'),
          Gap(8),
          _beOrganizerRow(),
        ],
      ),
    );
  }

  Row _organizerRow({
    required String name,
    required String followers,
    required String events,
    required String assets,
  }) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Palette.separatorColor,
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: AssetImage(assets),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Gap(8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.medium(
                name,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              AppText.small(
                '$followers followers \u2022 $events',
                fontWeight: FontWeight.w300,
              ),
              Gap(5),
            ],
          ),
        ),
        Icon(
          CupertinoIcons.chevron_right,
          color: Colors.black54,
          size: 16,
        )
      ],
    );
  }

  Row _beOrganizerRow() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Palette.separatorColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Icon(
              CupertinoIcons.plus,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ),
        Gap(8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.medium(
                'Devenir organisateur',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              AppText.small(
                'Organisez vos propres événements dès maintenant',
                fontWeight: FontWeight.w300,
              ),
              Gap(5),
            ],
          ),
        ),
        Icon(
          CupertinoIcons.chevron_right,
          color: Colors.black54,
          size: 16,
        )
      ],
    );
  }

  SizedBox _about() {
    List<String> _tags = [
      '🎓 Jeune diplômé(e) +',
      '🎒 Étudiant(e) +',
      '📍 Nouveau en ville +',
      '🏠 Nid vide +',
      '🎉 Retraité(e) récent(e) +',
      '👶 Jeune parent +',
      '💼 Reconversion professionnelle +'
    ];

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.large(
            'À propos de moi',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
          AppText.medium(
            'Sélectionnez ce qui vous correspond le mieux',
            fontSize: 14,
            color: Colors.black54,
          ),
          Gap(10),
          Wrap(
            spacing: 8.0, // Espacement horizontal entre les tags
            runSpacing: 8.0, // Espacement vertical entre les lignes de tags
            children: _tags.map((tag) {
              return DottedBorder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                radius: Radius.circular(5),
                borderType: BorderType.RRect,
                child: AppText.medium(
                  tag,
                  fontWeight: FontWeight.w400,
                ),
              );
            }).toList(),
          ),
          Gap(10),
          AppText.medium(
            'Présentez vous aux autres membres de anowan.com. Vous pouvez rediger un texte court et simple',
            fontSize: 14,
            color: Colors.black54,
          ),
          Gap(10),
          DottedBorder(
            color: Palette.appRed,
            radius: Radius.circular(5),
            borderType: BorderType.RRect,
            child: Container(
              color: Palette.appRed.withOpacity(0.05),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: double.infinity,
              child: AppText.medium(
                'Ajouter une bio',
                color: Palette.appRed,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _inviteFriends() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Palette.appRed.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Palette.appRed.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          AppText.large(
            'Gagnez un Ticket!',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
          SizedBox(height: 8),
          // Subtitle
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              children: [
                TextSpan(text: 'Invitez vos amis à'),
                TextSpan(
                  text: ' télécharger anowan.com',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                    text:
                        ' et participez à un tirage au sort pour gagner un ticket gratuit pour le prochain événement !'),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Invite Button
          Container(
            width: double.infinity,
            height: 38,
            decoration: BoxDecoration(
              color: Palette.appRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                // Logique d'invitation
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Anowan logo (remplacer par l'image du logo)
                  Image.asset(
                    'assets/images/anowan-invite-2.png',
                    height: 24,
                  ),
                  SizedBox(width: 8),
                  // Invite Text
                  AppText.medium(
                    'Inviter mes amis dès maintenant',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
          Gap(5),
        ],
      ),
    );
  }

  Row _userPicAndNames() {
    return Row(
      children: [
        UserProfilePic(),
        Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                'KOUAME Kendoubou Amon Franck Ariel',
                maxLine: 1,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 32, 32, 32),
              ),
              AppText.medium(
                '📬 kendoubou.amo@gmail.com',
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 80, 80, 80),
                maxLine: 1,
              ),
              AppText.medium(
                '📍Cocody Angré, Abidjan - Côte d\'Ivoire',
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 80, 80, 80),
                maxLine: 1,
              )
            ],
          ),
        )
      ],
    );
  }

  Container _sheetCloserBar() {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        color: Palette.separatorColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Container _topIconsContainer({required BuildContext context}) {
    return Container(
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildIcon(
              svgPath: 'assets/icons/angle-petit-gauche.svg',
              onTap: () => Navigator.of(context).pop(),
            ),
            Row(
              children: [
                buildIcon(
                  svgPath: 'assets/icons/crayon1.svg',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilSettings(),
                    ),
                  ),
                ),
                Gap(8),
                buildIcon(
                  svgPath: 'assets/icons/settings.svg',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AppSettingsScreen(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
