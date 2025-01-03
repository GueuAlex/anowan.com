import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

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
