import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/representatives_service.dart';

final representativesProvider = Provider<RepresentativesService>((ref) => const RepresentativesService());
