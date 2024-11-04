import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local_service/local_service.dart';

final localeServiceProvider = Provider<LocalService>((ref) {
  return LocalService();
});
