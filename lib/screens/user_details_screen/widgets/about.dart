import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
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
}
