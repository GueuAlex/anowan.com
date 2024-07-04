import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class CentreInteret extends StatefulWidget {
  const CentreInteret({
    super.key,
  });

  @override
  State<CentreInteret> createState() => _CentreInteretState();
}

class _CentreInteretState extends State<CentreInteret> {
  List<String> list = [
    "concert",
    "festival",
    "exposition",
    "théâtre",
    "cinéma",
    "conférence",
    "atelier",
    "séminaire",
    "webinaire",
    "cours de danse",
    "cours de cuisine",
    "tournoi sportif",
    "match de football",
    "match de basketball",
    "match de tennis",
    "marathon",
    "salon professionnel",
    "foire",
    "marché de Noël",
    "carnaval",
    "parade",
    "projection de film",
    "dégustation de vin",
    "soirée à thème",
    "bal",
    "rave",
    "festival de musique",
    "festival de cinéma",
    "festival de théâtre",
    "festival de danse",
    "festival de littérature",
    "rencontre littéraire",
    "bourse aux livres",
    "signature de livre",
    "rencontre d'auteur",
    "séance de dédicace",
    "projection de documentaire",
    "vernissage",
    "conférence de presse",
    "lancement de produit",
    "inauguration",
    "réception",
    "gala",
    "remise de prix",
    "foire d'art",
    "concert de musique classique",
    "concert de jazz",
    "concert de rock",
    "concert de pop",
    "concert de musique électronique",
    "concert de hip-hop",
    "spectacle de danse",
    "spectacle de magie",
    "spectacle de cirque",
    "comédie musicale",
    "pièce de théâtre",
    "one-man show",
    "stand-up",
    "atelier de peinture",
    "atelier de sculpture",
    "atelier de photographie",
    "atelier de dessin",
    "cours de yoga",
    "cours de méditation",
    "cours de fitness",
    "cours de pilates",
    "cours de natation",
    "cours de voile",
    "cours d'escalade",
    "randonnée",
    "trekking",
    "excursion",
    "sortie en bateau",
    "croisière",
    "camping",
    "pique-nique",
    "barbecue",
    "chasse au trésor",
    "escape game",
    "jeux de société",
    "tournoi de poker",
    "tournoi de jeux vidéo",
    "lan party",
    "conférence sur la technologie",
    "conférence sur la santé",
    "conférence sur l'environnement",
    "conférence sur l'économie",
    "conférence sur la politique",
    "conférence sur la science",
    "conférence sur l'histoire",
    "conférence sur la culture",
    "conférence sur les arts",
    "conférence sur le développement personnel",
    "séminaire de formation",
    "atelier d'écriture",
    "atelier de théâtre",
    "atelier de musique",
    "atelier de danse",
    "atelier de cuisine",
    "atelier de jardinage",
    "atelier de bricolage"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.medium(
              'Vos centres d\'intérêt',
              fontSize: (size.width * 0.042),
              fontWeight: FontWeight.w500,
            ),
            list.length > 0
                ? TextButton(
                    onPressed: () {},
                    child: AppText.medium(
                      'Modifier',
                      fontSize: (size.width * 0.040),
                      fontWeight: FontWeight.w700,
                      color: Palette.appRed,
                    ),
                  )
                : Container(),
          ],
        ),
        Gap(20),
        list.length > 0 ? _tags(list: list) : _dottedBorder(size)
      ],
    );
  }

  Widget _tags({required List<String> list}) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children:
          list.sublist(1, 10).map((interet) => _buildTag(interet)).toList(),
    );
  }

  DottedBorder _dottedBorder(Size size) {
    return DottedBorder(
      padding: const EdgeInsets.all(10),
      strokeWidth: 1,
      //borderPadding: EdgeInsets.all(5),
      radius: const Radius.circular(5),
      color: Colors.grey,
      borderType: BorderType.RRect,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AppText.medium(
              'Persoonalisez vos recommandations d\'évènements en fonction de vos intérêts',
              fontWeight: FontWeight.w300,
              fontSize: size.width * 0.042,
            ),
          ),
          Gap(10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 0.8, color: Palette.appRed),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AppText.medium(
              '+ Ajouter',
              color: Palette.appRed,
              fontSize: 15,
              //fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Palette.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () => _onTagTap(label),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.medium(
              label,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            Gap(5),
            Icon(
              CupertinoIcons.xmark,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  _onTagTap(String label) {}
}
