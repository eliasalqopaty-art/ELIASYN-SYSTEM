class Barcode {
  const Barcode({required this.code, this.type = 'EAN13'});

  final String code;
  final String type;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
