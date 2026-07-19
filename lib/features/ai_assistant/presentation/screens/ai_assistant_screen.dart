import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/assistant_provider.dart';

class AiAssistantScreen extends ConsumerStatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  ConsumerState<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends ConsumerState<AiAssistantScreen> {
  final TextEditingController _commandController = TextEditingController();
  final List<String> _history = <String>[];
  bool _isListening = false;
  String _lastResult = 'جاهز لاستخراج أوامر صوتية أو نصية.';

  @override
  void dispose() {
    _commandController.dispose();
    super.dispose();
  }

  Future<void> _execute(String rawCommand) async {
    final command = rawCommand.trim();
    if (command.isEmpty) return;

    final parser = ref.read(commandParserProvider);
    final assistant = ref.read(assistantServiceProvider);
    final voice = ref.read(voiceServiceProvider);

    final route = parser.parse(command);
    final guidance = assistant.guidance(command);
    final spoken = await voice.speak(guidance);

    setState(() {
      _lastResult = 'المسار: /$route\n$guidance\nرد الصوت: $spoken';
      _history.insert(0, '$command → /$route');
      if (_history.length > 8) _history.removeLast();
    });
  }

  Future<void> _listenVoice() async {
    setState(() => _isListening = true);
    final voice = ref.read(voiceServiceProvider);
    final input = await voice.listen();
    _commandController.text = input;
    await _execute(input);
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    const quickCommands = <String>[
      'افتح المخازن',
      'افتح الأدوية',
      'افتح التتبع',
      'افتح التقارير',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('المساعد الذكي'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Voice Command Panel',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                  'استخدم أوامر صوتية أو نصية، بدون API keys أو Gemini حقيقي.',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border)),
                child: Column(children: [
                  TextField(
                    controller: _commandController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'اكتب أمرًا مثل: افتح المخازن',
                      hintStyle:
                          const TextStyle(color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(spacing: 10, runSpacing: 10, children: [
                    for (final command in quickCommands)
                      ActionChip(
                        label: Text(command),
                        backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                        labelStyle: const TextStyle(color: AppColors.primary),
                        onPressed: () => _execute(command),
                      ),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isListening ? null : _listenVoice,
                        icon: const Icon(Icons.mic),
                        label: Text(
                            _isListening ? 'جاري الاستماع...' : 'استماع صوتي'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _execute(_commandController.text),
                        icon: const Icon(Icons.send),
                        label: const Text('تنفيذ الأمر'),
                      ),
                    ),
                  ]),
                ]),
              ),
              const SizedBox(height: 18),
              const Text('AI Assistant Screen',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border)),
                child: Text(_lastResult,
                    style: const TextStyle(color: AppColors.textPrimary)),
              ),
              const SizedBox(height: 18),
              const Text('Command History',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border)),
                  child: _history.isEmpty
                      ? const Center(
                          child: Text('لا يوجد سجل بعد',
                              style: TextStyle(color: AppColors.textSecondary)))
                      : ListView.separated(
                          itemCount: _history.length,
                          separatorBuilder: (_, __) =>
                              const Divider(color: AppColors.border, height: 1),
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(Icons.history,
                                color: AppColors.primary),
                            title: Text(_history[index],
                                style: const TextStyle(
                                    color: AppColors.textPrimary)),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
