import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/pharmacies_service.dart';

final pharmaciesProvider = Provider<PharmaciesService>((ref) => const PharmaciesService());
