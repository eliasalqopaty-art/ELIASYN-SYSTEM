import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class RecordDefinition {
  final String title;
  final IconData icon;
  final String owner;
  final String location;
  final String phone;
  final String status;
  final String metricLabel;
  final String metricValue;
  final Color color;
  final List<String> tags;

  const RecordDefinition({
    required this.title,
    required this.icon,
    required this.owner,
    required this.location,
    required this.phone,
    required this.status,
    required this.metricLabel,
    required this.metricValue,
    required this.color,
    this.tags = const [],
  });

  RecordDefinition copyWith({
    String? title,
    String? owner,
    String? location,
    String? phone,
    String? status,
    String? metricLabel,
    String? metricValue,
    List<String>? tags,
  }) {
    return RecordDefinition(
      title: title ?? this.title,
      icon: icon,
      owner: owner ?? this.owner,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      metricLabel: metricLabel ?? this.metricLabel,
      metricValue: metricValue ?? this.metricValue,
      color: color,
      tags: tags ?? this.tags,
    );
  }
}

class RecordsPage extends StatefulWidget {
  final String title;
  final String searchHint;
  final String addLabel;
  final IconData icon;
  final List<RecordDefinition> initialRecords;

  const RecordsPage({
    super.key,
    required this.title,
    required this.searchHint,
    required this.addLabel,
    required this.icon,
    required this.initialRecords,
  });

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final _searchController = TextEditingController();
  late final List<RecordDefinition> _records = [...widget.initialRecords];
  String _query = '';
  String _status = 'الكل';

  List<String> get _statuses {
    return [
      'الكل',
      ...{for (final item in _records) item.status}
    ];
  }

  List<RecordDefinition> get _filteredRecords {
    final normalized = _query.trim().toLowerCase();
    return _records.where((item) {
      final matchesStatus = _status == 'الكل' || item.status == _status;
      final text = [
        item.title,
        item.owner,
        item.location,
        item.phone,
        item.status,
        ...item.tags,
      ].join(' ').toLowerCase();
      return matchesStatus && (normalized.isEmpty || text.contains(normalized));
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: Text(widget.title),
          actions: [
            ElevatedButton.icon(
              onPressed: _showAddDialog,
              icon: const Icon(Icons.add, size: 18),
              label: Text(widget.addLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _SummaryStrip(records: _records, icon: widget.icon),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _query = value),
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: widget.searchHint,
                        hintStyle:
                            const TextStyle(color: AppColors.textSecondary),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButtonHideUnderline(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: DropdownButton<String>(
                        value: _status,
                        dropdownColor: AppColors.surface,
                        iconEnabledColor: AppColors.textSecondary,
                        style: const TextStyle(color: AppColors.textPrimary),
                        items: [
                          for (final status in _statuses)
                            DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _status = value);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: _export,
                    icon: const Icon(Icons.download),
                    label: const Text('تصدير'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '${widget.title} (${records.length})',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(color: AppColors.border, height: 1),
                      Expanded(
                        child: records.isEmpty
                            ? _EmptyRecords(icon: widget.icon)
                            : ListView.separated(
                                itemCount: records.length,
                                separatorBuilder: (_, __) => const Divider(
                                  color: AppColors.border,
                                  height: 1,
                                ),
                                itemBuilder: (context, index) {
                                  final record = records[index];
                                  return _RecordRow(
                                    record: record,
                                    onTap: () => _showDetails(record),
                                    onDelete: () {
                                      setState(() => _records.remove(record));
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAddDialog() async {
    final title = TextEditingController();
    final owner = TextEditingController();
    final location = TextEditingController();
    final phone = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.addLabel),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  decoration: const InputDecoration(labelText: 'الاسم'),
                ),
                TextField(
                  controller: owner,
                  decoration: const InputDecoration(labelText: 'المسؤول'),
                ),
                TextField(
                  controller: location,
                  decoration: const InputDecoration(labelText: 'الموقع'),
                ),
                TextField(
                  controller: phone,
                  textDirection: TextDirection.ltr,
                  decoration: const InputDecoration(labelText: 'الهاتف'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () {
                final name = title.text.trim();
                if (name.isEmpty) return;
                setState(() {
                  _records.insert(
                    0,
                    RecordDefinition(
                      title: name,
                      icon: widget.icon,
                      owner: owner.text.trim().isEmpty
                          ? 'غير محدد'
                          : owner.text.trim(),
                      location: location.text.trim().isEmpty
                          ? 'غير محدد'
                          : location.text.trim(),
                      phone:
                          phone.text.trim().isEmpty ? '-' : phone.text.trim(),
                      status: 'نشط',
                      metricLabel: 'عمليات',
                      metricValue: '0',
                      color: AppColors.primary,
                      tags: const ['جديد'],
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );

    title.dispose();
    owner.dispose();
    location.dispose();
    phone.dispose();
  }

  void _showDetails(RecordDefinition record) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(record.title),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailLine(label: 'المسؤول', value: record.owner),
                _DetailLine(label: 'الموقع', value: record.location),
                _DetailLine(label: 'الهاتف', value: record.phone),
                _DetailLine(label: 'الحالة', value: record.status),
                _DetailLine(
                  label: record.metricLabel,
                  value: record.metricValue,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in record.tags) Chip(label: Text(tag)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('تم'),
            ),
          ],
        );
      },
    );
  }

  void _export() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تجهيز ${_filteredRecords.length} سجل للتصدير'),
      ),
    );
  }
}

class _SummaryStrip extends StatelessWidget {
  final List<RecordDefinition> records;
  final IconData icon;

  const _SummaryStrip({required this.records, required this.icon});

  @override
  Widget build(BuildContext context) {
    final active = records.where((item) => item.status == 'نشط').length;
    final pending = records.where((item) => item.status != 'نشط').length;
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'الإجمالي',
            value: records.length.toString(),
            icon: icon,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'نشط',
            value: active.toString(),
            icon: Icons.check_circle_outline,
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'بحاجة متابعة',
            value: pending.toString(),
            icon: Icons.pending_actions,
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordRow extends StatelessWidget {
  final RecordDefinition record;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _RecordRow({
    required this.record,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = record.status == 'نشط'
        ? AppColors.success
        : record.status == 'متوقف'
            ? AppColors.danger
            : AppColors.warning;

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: record.color.withValues(alpha: 0.18),
        child: Icon(record.icon, color: record.color, size: 20),
      ),
      title: Text(
        record.title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${record.owner} • ${record.location}\n${record.phone}',
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      isThreeLine: true,
      trailing: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Chip(
            label: Text(record.status),
            backgroundColor: statusColor.withValues(alpha: 0.15),
            labelStyle: TextStyle(color: statusColor),
            side: BorderSide(color: statusColor.withValues(alpha: 0.3)),
          ),
          SizedBox(
            width: 92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  record.metricValue,
                  style: TextStyle(
                    color: record.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  record.metricLabel,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'حذف',
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: AppColors.danger),
          ),
        ],
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyRecords extends StatelessWidget {
  final IconData icon;

  const _EmptyRecords({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 60),
          const SizedBox(height: 16),
          const Text(
            'لا توجد بيانات مطابقة',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
