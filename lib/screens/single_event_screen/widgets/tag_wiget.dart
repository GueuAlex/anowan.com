import 'package:flutter/material.dart';
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
      runSpacing: 8.0, // Espace vertical entre les tags
      children: tags.map((tag) {
        return Chip(
          label: Text(tag),
          backgroundColor: Palette.primaryColor.withOpacity(0.1),
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        );
      }).toList(),
    );
  }
}
