class AuthSession {
  final String userId;
  final String email;
  final List<String> roles;
  final DateTime startedAt;

  const AuthSession({
    required this.userId,
    required this.email,
    required this.roles,
    required this.startedAt,
  });

  factory AuthSession.fromMap(Map<String, dynamic> map) {
    return AuthSession(
      userId: map['userId'] as String,
      email: map['email'] as String,
      roles: List<String>.from(map['roles'] as List? ?? const []),
      startedAt: DateTime.parse(map['startedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'roles': roles,
      'startedAt': startedAt.toIso8601String(),
    };
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
