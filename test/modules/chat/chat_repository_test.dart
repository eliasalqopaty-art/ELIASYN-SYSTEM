import 'package:alasim_management/features/chat/data/repositories/chat_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChatRepository returns mock rooms for all core channels', () async {
    final repository = const ChatRepository();

    final rooms = await repository.loadRooms();

    expect(
        rooms.map((room) => room.channel),
        containsAll(
            ['General', 'Operations', 'Warehouse', 'Management', 'Audit']));
    expect(rooms.any((room) => room.isPrivate), isTrue);
    expect(rooms.any((room) => room.isPinned), isTrue);
    expect(rooms.any((room) => room.unreadCount > 0), isTrue);
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
