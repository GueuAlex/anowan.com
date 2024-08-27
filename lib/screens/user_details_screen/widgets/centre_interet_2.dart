import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../constants/tags.dart';
import '../../../providers/providers.dart';
import '../../../widgets/tags_builder.dart';

class CentreInteret2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTags = ref.watch(tagsProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.large(
            'Vos centres d\'intérêt',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
          AppText.medium(
            'Sélectionnez vos passe-temps préférés : Découvrez les evenements qui vous correspondent',
            fontSize: 14,
            color: Colors.black54,
          ),
          Gap(10),
          tagsBuilder(
            tags: tags.sublist(0, 9),
            selectedTags: selectedTags,
            ref: ref,
          ),
        ],
      ),
    );
  }
}
