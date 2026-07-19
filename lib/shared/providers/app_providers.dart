import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/auth_service.dart';
import '../../core/services/offline_sync_service.dart';
import '../../core/services/supabase_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => const AuthService());
final supabaseServiceProvider =
    Provider<SupabaseService>((ref) => const SupabaseService());
final offlineSyncServiceProvider =
    Provider<OfflineSyncService>((ref) => const OfflineSyncService());
