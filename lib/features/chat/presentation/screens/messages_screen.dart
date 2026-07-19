import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/chat_provider.dart';
import '../../domain/models/message_model.dart';
import 'private_chat_screen.dart';

class MessagesScreen extends ConsumerWidget {
  final String roomId;

  const MessagesScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomState = ref.watch(roomDetailsProvider(roomId));

    return Directionality(
      textDirection: TextDirection.rtl,
      child: roomState.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) => Scaffold(
            appBar: AppBar(title: const Text('الرسائل')),
            body: Center(
                child: Text('فشل تحميل الرسائل: $error',
                    style: const TextStyle(color: AppColors.danger)))),
        data: (room) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              title: Text(room?.title ?? 'المحادثة'),
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PrivateChatScreen(roomId: roomId))),
                  icon: const Icon(Icons.chat),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _PinnedMessages(
                      messages: room?.messages ?? const <MessageModel>[]),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: ListView(
                        children: [
                          for (final message
                              in room?.messages ?? const <MessageModel>[])
                            _MessageBubble(message: message),
                        ],
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

class _PinnedMessages extends StatelessWidget {
  final List<MessageModel> messages;

  const _PinnedMessages({required this.messages});

  @override
  Widget build(BuildContext context) {
    final pinned = messages.where((message) => message.isPinned).toList();
    if (pinned.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Pinned Messages',
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        for (final message in pinned)
          Text('📌 ${message.author}: ${message.text}',
              style: const TextStyle(color: AppColors.textPrimary)),
      ]),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MessageModel message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(message.author,
            style: const TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(message.text,
            style: const TextStyle(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        if (message.attachments.isNotEmpty)
          Text('Attachments: ${message.attachments.join(', ')}',
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 12)),
      ]),
    );
  }
}
