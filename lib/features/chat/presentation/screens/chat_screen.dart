import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/chat_provider.dart';
import '../../domain/models/chat_room_model.dart';
import 'messages_screen.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsState = ref.watch(chatRoomsProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: roomsState.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('قنوات الدردشة')),
          body: Center(
              child: Text('فشل تحميل القنوات: $error',
                  style: const TextStyle(color: AppColors.danger))),
        ),
        data: (rooms) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              title: const Text('Channels'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Chip(
                    label: Text('${rooms.length} قناة'),
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    labelStyle: const TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _ChatSummary(rooms: rooms),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: ListView.separated(
                        itemCount: rooms.length,
                        separatorBuilder: (_, __) =>
                            const Divider(color: AppColors.border, height: 1),
                        itemBuilder: (context, index) {
                          return _ChannelRow(room: rooms[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ChatSummary extends StatelessWidget {
  final List<ChatRoomModel> rooms;

  const _ChatSummary({required this.rooms});

  @override
  Widget build(BuildContext context) {
    final pinned = rooms.where((room) => room.isPinned).length;
    final unread =
        rooms.fold<int>(0, (total, room) => total + room.unreadCount);

    return Row(
      children: [
        Expanded(
            child: _SummaryCard(
                label: 'Pinned Messages',
                value: pinned.toString(),
                icon: Icons.push_pin,
                color: AppColors.warning)),
        const SizedBox(width: 12),
        Expanded(
            child: _SummaryCard(
                label: 'Unread Counter',
                value: unread.toString(),
                icon: Icons.mark_unread_chat_alt,
                color: AppColors.primary)),
        const SizedBox(width: 12),
        const Expanded(
            child: _SummaryCard(
                label: 'Attachments Placeholder',
                value: 'Ready',
                icon: Icons.attach_file,
                color: AppColors.success)),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(label,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
                Text(value,
                    style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ])),
        ],
      ),
    );
  }
}

class _ChannelRow extends ConsumerWidget {
  final ChatRoomModel room;

  const _ChannelRow({required this.room});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        ref.read(selectedRoomProvider.notifier).state = room.id;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => MessagesScreen(roomId: room.id)));
      },
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withValues(alpha: 0.16),
        child: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
      ),
      title: Text(room.title,
          style: const TextStyle(color: AppColors.textPrimary)),
      subtitle: Text('${room.description} • ${room.members.join(', ')}',
          style: const TextStyle(color: AppColors.textSecondary)),
      trailing: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (room.isPinned)
            const Icon(Icons.push_pin, size: 16, color: AppColors.warning),
          if (room.unreadCount > 0)
            CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.primary,
                child: Text(room.unreadCount.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white))),
        ],
      ),
    );
  }
}
