// Provider pour le service API
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../remote_service/remote_service.dart';

final apiServiceProvider = Provider<RemoteService>((ref) => RemoteService());
