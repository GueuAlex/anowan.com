import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_service_provider.dart';

// Provider pour gérer les events favoris
final bookmarkedEventsProvider =
    StateNotifierProvider<BookmarkedEventsNotifier, List<String>>((ref) {
  return BookmarkedEventsNotifier(ref);
});

// StateNotifier pour gérer la liste des vents favoris
class BookmarkedEventsNotifier extends StateNotifier<List<String>> {
  final Ref _ref;

  // Le constructeur prend un `Ref` pour accéder aux autres providers, comme `LocaleService`
  BookmarkedEventsNotifier(this._ref) : super([]);

  // Méthode pour ajouter un event aux favoris
  Future<void> addEvent(String eventId) async {
    final localeService = _ref.read(localeServiceProvider);

    // Ajoute l'event aux favoris en utilisant la méthode existante
    final result = await localeService.addBookmarkedEvent(eventId);

    if (result > 0 && !state.contains(eventId)) {
      // Met à jour l'état avec la nouvelle liste
      state = [...state, eventId];
    }
  }

  // Charger la liste des events favoris depuis la base de données
  Future<void> loadBookmarkedEvents() async {
    final localeService = _ref.read(localeServiceProvider);

    // Récupère la liste des ID des organisateurs suivis depuis la base de données locale
    final List<String> savedOrganizers =
        await localeService.getBookmarkedEvents();
    state = savedOrganizers;
  }
}
