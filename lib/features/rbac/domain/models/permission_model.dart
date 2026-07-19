class PermissionModel {
  const PermissionModel({
    required this.code,
    required this.label,
    required this.description,
  });

  final String code;
  final String label;
  final String description;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
