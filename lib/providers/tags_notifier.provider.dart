import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsNotifier extends StateNotifier<List<String>> {
  TagsNotifier() : super([]);

  // Ajouter un tag
  void addTag(String tag) {
    if (!state.contains(tag)) {
      state = [...state, tag];
    }
  }

  // Supprimer un tag
  void removeTag(String tag) {
    state = state.where((t) => t != tag).toList();
  }
}
