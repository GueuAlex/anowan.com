import 'package:flutter/material.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';

class TagWidget extends StatelessWidget {
  final List<String> tags;

  const TagWidget({
    required this.tags,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Espace horizontal entre les tags
      runSpacing: 10.0, // Espace vertical entre les tags
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Palette.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: AppText.small(
            tag,
            fontSize: 14,
          ),
        );
      }).toList(),
    );
  }
}

/* 
 j'ai besoin d'afficher des tag comme ceci
"today -> return la date d'aujourd'huit"
"tomorrow -> return la date de demain"
"this weekend" -> return la date du weekend (samedi et dimanche de la semaine en coure)
"choisir la date " -> return la une date un date range selectionnée par l'utilsateur
"All coming"

 */
