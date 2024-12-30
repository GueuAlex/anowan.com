// FutureProvider pour charger les events une seule fois

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_service.provider.dart';

final ticketsProvider = FutureProvider.family<List<dynamic>, int?>(
  (ref, userId) async {
    final apiService = ref.watch(apiServiceProvider);
    if (userId == null) return [];

    return apiService.getTickets(userId: userId);
  },
);
