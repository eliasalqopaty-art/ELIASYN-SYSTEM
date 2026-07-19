import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/branches_service.dart';

final branchesProvider = Provider<BranchesService>((ref) => const BranchesService());
