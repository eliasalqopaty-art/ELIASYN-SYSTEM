class PharmaciesModel {
  const PharmaciesModel({
    required this.id,
    required this.name,
    this.status = 'ready',
  });

  final String id;
  final String name;
  final String status;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
