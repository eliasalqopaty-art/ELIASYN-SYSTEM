import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../audit_trail/application/providers/audit_controller.dart';
import '../../domain/entities/app_user.dart';

final usersBoxProvider = Provider<Box<Map>>((ref) => Hive.box<Map>('users'));
final sessionBoxProvider = Provider<Box>((ref) => Hive.box('session'));

final usersControllerProvider =
    StateNotifierProvider<UsersController, UsersState>((ref) {
  return UsersController(ref)..load();
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref)..restoreSession();
});

class UsersState {
  final List<AppUser> users;
  final bool isLoading;
  final String? errorMessage;

  const UsersState({
    this.users = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  UsersState copyWith({
    List<AppUser>? users,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return UsersState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class AuthState {
  final AppUser? currentUser;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.currentUser,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isAuthenticated => currentUser != null;

  AuthState copyWith({
    AppUser? currentUser,
    bool clearCurrentUser = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      currentUser: clearCurrentUser ? null : currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class UsersController extends StateNotifier<UsersState> {
  final Ref ref;
  final _uuid = const Uuid();

  UsersController(this.ref) : super(const UsersState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    await _ensureSeedUser();
    final users = ref.read(usersBoxProvider).values.map(_fromStoredMap).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    state = state.copyWith(users: users, isLoading: false);
  }

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
    required List<String> roles,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final exists = state.users.any((user) => user.email == normalizedEmail);
    if (exists) {
      state = state.copyWith(errorMessage: 'البريد الإلكتروني مستخدم بالفعل');
      return;
    }

    final now = DateTime.now();
    final user = AppUser(
      id: _uuid.v4(),
      name: name.trim(),
      email: normalizedEmail,
      passwordHash: hashPassword(password),
      roles: roles.isEmpty ? const ['viewer'] : roles,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );

    await ref.read(usersBoxProvider).put(user.id, user.toMap());
    await ref.read(auditControllerProvider.notifier).log(
      actor: 'system',
      action: 'user_created',
      target: user.email,
      metadata: {'roles': user.roles},
    );
    await load();
  }

  Future<void> updateRoles(String userId, List<String> roles) async {
    final user = state.users.where((item) => item.id == userId).firstOrNull;
    if (user == null) return;
    final updated = user.copyWith(
      roles: roles.isEmpty ? const ['viewer'] : roles,
      updatedAt: DateTime.now(),
    );
    await ref.read(usersBoxProvider).put(updated.id, updated.toMap());
    await ref.read(auditControllerProvider.notifier).log(
      actor: 'system',
      action: 'user_roles_updated',
      target: updated.email,
      metadata: {'roles': updated.roles},
    );
    await load();
  }

  Future<void> toggleActive(String userId) async {
    final user = state.users.where((item) => item.id == userId).firstOrNull;
    if (user == null) return;
    final updated = user.copyWith(
      isActive: !user.isActive,
      updatedAt: DateTime.now(),
    );
    await ref.read(usersBoxProvider).put(updated.id, updated.toMap());
    await ref.read(auditControllerProvider.notifier).log(
          actor: 'system',
          action: updated.isActive ? 'user_activated' : 'user_deactivated',
          target: updated.email,
        );
    await load();
  }

  Future<void> _ensureSeedUser() async {
    final box = ref.read(usersBoxProvider);
    if (box.isNotEmpty) return;

    final now = DateTime.now();
    final admin = AppUser(
      id: 'admin',
      name: 'مدير النظام',
      email: 'admin@alasim.local',
      passwordHash: hashPassword('admin123'),
      roles: const ['admin', 'manager'],
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
    await box.put(admin.id, admin.toMap());
  }

  AppUser _fromStoredMap(Map value) {
    return AppUser.fromMap(Map<String, dynamic>.from(value));
  }
}

class AuthController extends StateNotifier<AuthState> {
  final Ref ref;

  AuthController(this.ref) : super(const AuthState());

  Future<void> restoreSession() async {
    state = state.copyWith(isLoading: true, clearError: true);
    await ref.read(usersControllerProvider.notifier).load();
    final userId = ref.read(sessionBoxProvider).get('currentUserId') as String?;
    if (userId == null) {
      state = state.copyWith(isLoading: false, clearCurrentUser: true);
      return;
    }
    final users = ref.read(usersControllerProvider).users;
    final user = users.where((item) => item.id == userId).firstOrNull;
    state = state.copyWith(currentUser: user, isLoading: false);
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    await ref.read(usersControllerProvider.notifier).load();
    final normalizedEmail = email.trim().toLowerCase();
    final users = ref.read(usersControllerProvider).users;
    final user =
        users.where((item) => item.email == normalizedEmail).firstOrNull;

    if (user == null ||
        user.passwordHash != hashPassword(password) ||
        !user.isActive) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'بيانات الدخول غير صحيحة أو المستخدم غير نشط',
      );
      await ref.read(auditControllerProvider.notifier).log(
            actor: normalizedEmail,
            action: 'login_failed',
            target: 'auth',
          );
      return false;
    }

    await ref.read(sessionBoxProvider).put('currentUserId', user.id);
    state = state.copyWith(currentUser: user, isLoading: false);
    await ref.read(auditControllerProvider.notifier).log(
          actor: user.email,
          action: 'login_success',
          target: 'auth',
        );
    return true;
  }

  Future<void> logout() async {
    final actor = state.currentUser?.email ?? 'system';
    await ref.read(sessionBoxProvider).delete('currentUserId');
    state = state.copyWith(clearCurrentUser: true);
    await ref.read(auditControllerProvider.notifier).log(
          actor: actor,
          action: 'logout',
          target: 'auth',
        );
  }
}

String hashPassword(String value) {
  return sha256.convert(utf8.encode(value)).toString();
}
