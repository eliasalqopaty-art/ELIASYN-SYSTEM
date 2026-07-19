class Batch {
  const Batch({
    required this.code,
    required this.productionDate,
    required this.expiryDate,
  });

  final String code;
  final String productionDate;
  final String expiryDate;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
