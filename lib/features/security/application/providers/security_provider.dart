import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/security_service.dart';

final securityServiceProvider =
    Provider<SecurityService>((ref) => const SecurityService());

final securityRequestsProvider =
    FutureProvider((ref) => ref.watch(securityServiceProvider).loadRequests());
