import '../../domain/models/approval_request_model.dart';
import '../repositories/security_repository.dart';

class SecurityService {
  const SecurityService({this.repository = const SecurityRepository()});

  final SecurityRepository repository;

  Future<List<ApprovalRequestModel>> loadRequests() =>
      repository.fetchRequests();

  Future<List<ApprovalRequestModel>> loadHistory(String operation) async {
    final requests = await repository.fetchRequests();
    return requests.where((item) => item.operation == operation).toList();
  }

  Future<ApprovalRequestModel> approve(String id) async {
    final requests = await repository.fetchRequests();
    final target = requests.firstWhere((item) => item.id == id,
        orElse: () => requests.first);
    return target.copyWith(status: 'Approved');
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
