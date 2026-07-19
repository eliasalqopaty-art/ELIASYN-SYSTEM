class ApiClient {
  const ApiClient();

  Future<Map<String, dynamic>> get(String path) async =>
      {'path': path, 'status': 'placeholder'};
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
