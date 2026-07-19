import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/chat_repository.dart';
import '../../data/services/chat_service.dart';

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => const ChatRepository(),
);

final chatServiceProvider = Provider<ChatService>(
  (ref) => ChatService(repository: ref.watch(chatRepositoryProvider)),
);

final chatRoomsProvider =
    FutureProvider((ref) => ref.watch(chatServiceProvider).loadRooms());

final selectedRoomProvider = StateProvider<String?>((ref) => null);

final roomDetailsProvider = FutureProvider.family((ref, String roomId) async {
  return ref.watch(chatServiceProvider).readRoom(roomId);
});
