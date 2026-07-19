class MedicinesRepository {
  const MedicinesRepository();

  Future<List<Map<String, dynamic>>> fetchAll() async =>
      const <Map<String, dynamic>>[
        {
          'id': 'med-1',
          'tradeName': 'باراسيتامول بلس',
          'genericName': 'Paracetamol',
          'manufacturer': 'شركة الأمل للصناعات الدوائية',
          'dosageForm': 'قرص',
          'strength': '500mg',
          'batchNumber': 'B-2026-001',
          'expiryDate': '2027-11-30',
          'lotNumber': 'LOT-001',
        },
        {
          'id': 'med-2',
          'tradeName': 'أموكسيسيلين',
          'genericName': 'Amoxicillin',
          'manufacturer': 'شركة الحياة الدوائية',
          'dosageForm': 'كبسولة',
          'strength': '250mg',
          'batchNumber': 'B-2025-077',
          'expiryDate': '2026-06-15',
          'lotNumber': 'LOT-042',
        },
        {
          'id': 'med-3',
          'tradeName': 'ديكلوفيناك مسكن',
          'genericName': 'Diclofenac',
          'manufacturer': 'معمل الشفاء',
          'dosageForm': 'جل',
          'strength': '1%',
          'batchNumber': 'B-2024-314',
          'expiryDate': '2025-01-20',
          'lotNumber': 'LOT-087',
        },
      ];

  Future<Map<String, dynamic>> fetchById(String id) async {
    final items = await fetchAll();
    return items.firstWhere(
      (item) => item['id'] == id,
      orElse: () => {
        'id': id,
        'tradeName': 'غير معروف',
        'genericName': 'غير معروف',
        'manufacturer': 'غير معروف',
        'dosageForm': 'غير معروف',
        'strength': 'غير معروف',
        'batchNumber': 'غير معروف',
        'expiryDate': 'غير معروف',
        'lotNumber': 'غير معروف',
      },
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
