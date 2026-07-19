import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/factories_service.dart';

final factoriesProvider = Provider<FactoriesService>((ref) => const FactoriesService());
