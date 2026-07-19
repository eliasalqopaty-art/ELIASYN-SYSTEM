class ConflictResolutionService {
  const ConflictResolutionService();

  Map<String, dynamic> resolve(
      Map<String, dynamic> local, Map<String, dynamic> remote) {
    return remote.isNotEmpty ? remote : local;
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
