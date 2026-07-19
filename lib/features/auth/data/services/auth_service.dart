import '../repositories/auth_repository.dart';

class AuthService {
  const AuthService({ this.repository = const AuthRepository() });

  final AuthRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
