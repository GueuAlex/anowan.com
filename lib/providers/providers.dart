import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketwave/model/event_model.dart';

import '../model/organizer_model.dart';
import '../model/prestator_model.dart';
import 'api_service.provider.dart';
import 'tags_notifier.provider.dart';

// Provider pour les tags
final tagsProvider = StateNotifierProvider<TagsNotifier, List<String>>((ref) {
  return TagsNotifier();
});

// FutureProvider pour charger les organisateurs une seule fois
final oragnizersProvider = FutureProvider<List<OrganizerModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getOrganisers();
});

// FutureProvider pour charger les prestataires une seule fois
final prestatorsProvider = FutureProvider<List<PrestatorMdel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);

  return apiService.getServceProviders();
});

// FutureProvider pour charger les events d'un organisateur une seule fois
final organizeEventsProvider =
    FutureProvider.family<List<EventModel>, String>((ref, organizerId) async {
  final apiService = ref.watch(apiServiceProvider);

  return apiService.getOrganizerEvents(organizerId: organizerId);
});

final selectedCategoryProvider = StateProvider<String>((ref) {
  return "Tout"; // Catégorie par défaut
});
