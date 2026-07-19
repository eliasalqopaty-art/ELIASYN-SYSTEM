import '../repositories/users_repository.dart';

class UsersService {
  const UsersService({ this.repository = const UsersRepository() });

  final UsersRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
