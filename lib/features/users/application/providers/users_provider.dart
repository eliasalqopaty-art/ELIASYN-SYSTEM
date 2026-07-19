import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/users_service.dart';

final usersProvider = Provider<UsersService>((ref) => const UsersService());
