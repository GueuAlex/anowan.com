import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_service_provider.dart';

// Provider pour gérer les organisateurs suivis
final bookmarkedOrganizersProvider =
    StateNotifierProvider<BookmarkedOrganizersNotifier, List<String>>((ref) {
  return BookmarkedOrganizersNotifier(ref);
});

// StateNotifier pour gérer la liste des organisateurs suivis
class BookmarkedOrganizersNotifier extends StateNotifier<List<String>> {
  final Ref _ref;

  // Le constructeur prend un `Ref` pour accéder aux autres providers, comme `LocaleService`
  BookmarkedOrganizersNotifier(this._ref) : super([]);

  // Méthode pour ajouter un organisateur aux favoris
  Future<void> addOrganizer(String organizerId) async {
    final localeService = _ref.read(localeServiceProvider);

    // Ajoute l'organisateur aux favoris en utilisant la méthode existante
    final result = await localeService.addBookmarkedOrganizer(organizerId);

    if (result > 0 && !state.contains(organizerId)) {
      // Met à jour l'état avec la nouvelle liste
      state = [...state, organizerId];
    }
  }

  // Charger la liste des organisateurs suivis depuis la base de données
  Future<void> loadBookmarkedOrganizers() async {
    final localeService = _ref.read(localeServiceProvider);

    // Récupère la liste des ID des organisateurs suivis depuis la base de données locale
    final List<String> savedOrganizers =
        await localeService.getBookmarkedOrganizers();
    state = savedOrganizers;
  }
}
