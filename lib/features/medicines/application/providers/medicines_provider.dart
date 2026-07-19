import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/medicines_service.dart';
import '../../domain/models/medicines_model.dart';

final medicinesProvider =
    Provider<MedicinesService>((ref) => const MedicinesService());

final medicinesListProvider = FutureProvider<List<MedicinesModel>>(
  (ref) async {
    final snapshot = await ref.watch(medicinesProvider).load();
    return snapshot.map(MedicinesModel.fromMap).toList();
  },
);

final medicineDetailsProvider = FutureProvider.family<MedicinesModel, String>(
  (ref, id) async {
    final snapshot = await ref.watch(medicinesProvider).read(id);
    return MedicinesModel.fromMap(snapshot);
  },
);
