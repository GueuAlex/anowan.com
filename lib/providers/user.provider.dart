import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketwave/providers/local_service_provider.dart';
import '../model/user_model.dart';
import '../local_service/local_service.dart';

// StateNotifier pour gérer les opérations sur l'utilisateur
class UserNotifier extends StateNotifier<UserModel?> {
  final LocalService _localService;

  UserNotifier(this._localService) : super(null) {
    _loadUser();
  }

  // Fonction pour charger l'utilisateur depuis la base de données
  Future<void> _loadUser() async {
    state = await _localService.getUser();
  }

  // Fonction pour mettre à jour l'avatar
  Future<void> updateAvatar(String newAvatar) async {
    if (state != null) {
      await _localService.updateAvatar(newAvatar);
      state = state!.copyWith(avatar: newAvatar);
    }
  }

  // Fonction pour mettre à jour la bio
  Future<void> updateBio(String bio) async {
    if (state != null) {
      await _localService.updateBio(bio);
      state = state!.copyWith(bio: bio);
    }
  }

  // Fonction pour mettre à jour la localisation favorite
  Future<void> updateLocation(String location) async {
    if (state != null) {
      await _localService.updateLocation(location);
      state = state!.copyWith(favoriteLocation: location);
    }
  }

  // Fonction pour ajouter un centre d'intérêt
  Future<void> addInterest(String interest) async {
    if (state != null) {
      state!.interests.add(interest);
      await _localService.saveUser(state!);
      state = state!.copyWith(interests: List.from(state!.interests));
    }
  }

  // Fonction pour supprimer un centre d'intérêt
  Future<void> removeInterest(String interest) async {
    if (state != null && state!.interests.contains(interest)) {
      state!.interests.remove(interest);
      await _localService.saveUser(state!);
      state = state!.copyWith(interests: List.from(state!.interests));
    }
  }

  // Fonction pour ajouter un favori d'événement
  Future<void> addBookmarkedEvent(String eventId) async {
    if (state != null && !state!.bookmarkedEventsId.contains(eventId)) {
      state!.bookmarkedEventsId.add(eventId);
      await _localService.saveUser(state!);
      state = state!
          .copyWith(bookmarkedEventsId: List.from(state!.bookmarkedEventsId));
    }
  }

  // Charger la liste des événements favoris depuis la base de données
  Future<void> loadBookmarkedEvents() async {
    if (state != null) {
      final bookmarkedEvents = await _localService.getBookmarkedEvents();
      state = state!.copyWith(bookmarkedEventsId: bookmarkedEvents);
    }
  }

  // Fonction pour supprimer un favori d'événement
  Future<void> removeBookmarkedEvent(String eventId) async {
    if (state != null && state!.bookmarkedEventsId.contains(eventId)) {
      state!.bookmarkedEventsId.remove(eventId);
      await _localService.saveUser(state!);
      state = state!
          .copyWith(bookmarkedEventsId: List.from(state!.bookmarkedEventsId));
    }
  }

  // Fonction pour ajouter un organisateur dans les favoris
  Future<void> addBookmarkedOrganizer(String organizerId) async {
    if (state != null && !state!.bookmarkedOrganizersId.contains(organizerId)) {
      state!.bookmarkedOrganizersId.add(organizerId);
      await _localService.saveUser(state!);
      state = state!.copyWith(
          bookmarkedOrganizersId: List.from(state!.bookmarkedOrganizersId));
    }
  }

  // Fonction pour supprimer un organisateur des favoris
  Future<void> removeBookmarkedOrganizer(String organizerId) async {
    if (state != null && state!.bookmarkedOrganizersId.contains(organizerId)) {
      state!.bookmarkedOrganizersId.remove(organizerId);
      await _localService.saveUser(state!);
      state = state!.copyWith(
          bookmarkedOrganizersId: List.from(state!.bookmarkedOrganizersId));
    }
  }

  // Fonction pour vider l'utilisateur de la base de données
  Future<void> clearUser() async {
    await _localService.clearUserTable();
    state = null;
  }
}

// Provider pour accéder au UserNotifier
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  final localService = ref.watch(localeServiceProvider);
  return UserNotifier(localService);
});
