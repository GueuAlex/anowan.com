import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/country_model.dart';
import '../model/event_model.dart';
import '../model/operator_model.dart';
import '../model/organizer_model.dart';
import '../model/prestator_model.dart';
import '../model/third_party_model.dart';
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

// FutureProvider pour charger les events une seule fois
final eventsProvider = FutureProvider<List<EventModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getEvents();
});

// keyboard state provider
final keyboardVisibilityProvider = StateProvider<bool>((ref) => false);

//slected country provider
// StateProvider pour le pays sélectionné
final selectedCountryProvider =
    StateProvider<CountryModel?>((ref) => CountryModel.list[0]);

//slected country provider
// StateProvider pour le pays sélectionné (pays du bénéficiaire)
final bselectedCountryProvider =
    StateProvider<CountryModel?>((ref) => CountryModel.list[0]);

// Provider pour le lieu sélectionné
final selectedPlaceProvider = StateProvider<String?>((ref) => null);

///// order screen
// Provider for managing selected passes
final selectedPassProvider = StateProvider<Map<int, int>>((ref) => {});

// Provider for managing total price
final totalPriceProvider = StateProvider<int>((ref) => 0);

final selectedOperatorProvider = StateProvider<OperatorModel?>((ref) {
  return null; // Catégorie par défaut
});

final selectedEventProvider = StateProvider<EventModel?>((ref) {
  return null; // Catégorie par défaut
});

final selectedRecepientProvider = StateProvider<String>((ref) {
  return 'E-mail'; // Catégorie par défaut
});

final thirdPartyProvider = StateProvider<ThirdPartyModel?>((ref) {
  return null; // Catégorie par défaut
});

final selectedTickedProvider = StateProvider<List<SelectedTickeModel>?>((ref) {
  return null; // Catégorie par défaut
});

class SelectedTickeModel {
  final int passId;
  final ThirdPartyModel? thirdParty;

  SelectedTickeModel({
    required this.passId,
    this.thirdParty,
  });
}
