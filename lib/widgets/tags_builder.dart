import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../config/app_text.dart';
import '../config/palette.dart';
import '../providers/providers.dart';

Widget tagsBuilder({
  required List<String> tags,
  required List<String> selectedTags,
  required WidgetRef ref,
}) {
  return Wrap(
    spacing: 10.0,
    runSpacing: 10.0,
    children: tags
        .map((tag) => buildTag(
              label: tag,
              isSelected: selectedTags.contains(tag),
              onTap: () {
                final tagsNotifier = ref.read(tagsProvider.notifier);
                if (selectedTags.contains(tag)) {
                  tagsNotifier.removeTag(tag);
                } else {
                  tagsNotifier.addTag(tag);
                }
              },
            ))
        .toList(),
  );
}

Widget buildTag({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color:
          isSelected ? Palette.appRed : Palette.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.medium(
            label,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: isSelected ? Palette.whiteColor : Colors.black,
          ),
          const Gap(5),
          Icon(
            isSelected ? CupertinoIcons.xmark : CupertinoIcons.add,
            size: 14,
            color: isSelected ? Palette.whiteColor : null,
          ),
        ],
      ),
    ),
  );
}
