import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/roles_service.dart';

final rolesProvider = Provider<RolesService>((ref) => const RolesService());
