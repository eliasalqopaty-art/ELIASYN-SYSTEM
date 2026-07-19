import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/inventory_provider.dart';
import '../../domain/models/inventory_item.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  String _packageFilter = 'الكل';
  String _sortBy = 'SKU';
  InventoryItem? _selectedItem;

  List<InventoryItem> _applyFilters(List<InventoryItem> items) {
    final normalizedQuery = _query.trim().toLowerCase();
    return items.where((item) {
      final matchesFilter =
          _packageFilter == 'الكل' || item.packageType == _packageFilter;
      final matchesQuery = normalizedQuery.isEmpty ||
          [
            item.sku,
            item.barcode,
            item.batch,
            item.expiryDate,
            item.packageType,
            item.packageColor,
          ].any((value) => value.toLowerCase().contains(normalizedQuery));
      return matchesFilter && matchesQuery;
    }).toList();
  }

  List<InventoryItem> _applySort(List<InventoryItem> items) {
    final sortedItems = [...items];
    sortedItems.sort((a, b) {
      switch (_sortBy) {
        case 'Expiry':
          final aDate = DateTime.tryParse(a.expiryDate) ?? DateTime(2100);
          final bDate = DateTime.tryParse(b.expiryDate) ?? DateTime(2100);
          return aDate.compareTo(bDate);
        case 'Package':
          return a.packageType.compareTo(b.packageType);
        case 'SKU':
        default:
          return a.sku.compareTo(b.sku);
      }
    });
    return sortedItems;
  }

  bool _isExpiringSoon(InventoryItem item) {
    final expiry = DateTime.tryParse(item.expiryDate);
    if (expiry == null) return false;
    return expiry.isBefore(DateTime.now().add(const Duration(days: 90)));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(inventoryItemsProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: inventoryState.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('إدارة المخزون')),
          body: Center(
            child: Text(
              'فشل تحميل بيانات المخزون: $error',
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ),
        data: (items) {
          final filters = _applyFilters(items);
          final sortedItems = _applySort(filters);
          final expiringCount = items.where(_isExpiringSoon).length;
          final packageTypes = [
            'الكل',
            ...{for (final item in items) item.packageType},
          ];
          final selectedItem =
              _selectedItem != null && sortedItems.contains(_selectedItem)
                  ? _selectedItem
                  : sortedItems.isNotEmpty
                      ? sortedItems.first
                      : null;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              title: const Text('إدارة المخزون'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _SummaryStrip(
                    totalItems: items.length,
                    expiringSoon: expiringCount,
                    packageCount:
                        {for (final item in items) item.packageType}.length,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) => setState(() => _query = value),
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            hintText: 'بحث في الأصناف، الباتش، الرمز',
                            hintStyle:
                                const TextStyle(color: AppColors.textSecondary),
                            prefixIcon: const Icon(Icons.search,
                                color: AppColors.textSecondary),
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
                            value: _packageFilter,
                            dropdownColor: AppColors.surface,
                            iconEnabledColor: AppColors.textSecondary,
                            style:
                                const TextStyle(color: AppColors.textPrimary),
                            items: [
                              for (final packageType in packageTypes)
                                DropdownMenuItem(
                                  value: packageType,
                                  child: Text(packageType),
                                ),
                            ],
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => _packageFilter = value);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      DropdownButtonHideUnderline(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: DropdownButton<String>(
                            value: _sortBy,
                            dropdownColor: AppColors.surface,
                            iconEnabledColor: AppColors.textSecondary,
                            style:
                                const TextStyle(color: AppColors.textPrimary),
                            items: const [
                              DropdownMenuItem(
                                  value: 'SKU', child: Text('ترتيب حسب SKU')),
                              DropdownMenuItem(
                                  value: 'Expiry',
                                  child: Text('ترتيب حسب تاريخ الانتهاء')),
                              DropdownMenuItem(
                                  value: 'Package',
                                  child: Text('ترتيب حسب النوع')),
                            ],
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => _sortBy = value);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'تم تجهيز ${sortedItems.length} صنف للتصدير'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('تصدير'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 980;
                        return Flex(
                          direction: isWide ? Axis.horizontal : Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: isWide ? 2 : 1,
                              child: Container(
                                margin:
                                    EdgeInsets.only(bottom: isWide ? 0 : 16),
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
                                        'أصناف المخزون (${sortedItems.length})',
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                        color: AppColors.border, height: 1),
                                    Expanded(
                                      child: sortedItems.isEmpty
                                          ? const _EmptyInventory()
                                          : ListView.separated(
                                              itemCount: sortedItems.length,
                                              separatorBuilder: (_, __) =>
                                                  const Divider(
                                                color: AppColors.border,
                                                height: 1,
                                              ),
                                              itemBuilder: (context, index) {
                                                return _InventoryRow(
                                                  item: sortedItems[index],
                                                  onTap: () {
                                                    if (isWide) {
                                                      setState(() {
                                                        _selectedItem =
                                                            sortedItems[index];
                                                      });
                                                    } else {
                                                      _showInventoryDetails(
                                                        context,
                                                        sortedItems[index],
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isWide) const SizedBox(width: 20),
                            if (isWide)
                              Expanded(
                                flex: 1,
                                child:
                                    _InventoryDetailPanel(item: selectedItem),
                              ),
                          ],
                        );
                      },
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

  void _showInventoryDetails(BuildContext context, InventoryItem item) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تفاصيل ${item.sku}'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailLine(label: 'SKU', value: item.sku),
                _DetailLine(label: 'الباركود', value: item.barcode),
                _DetailLine(label: 'الباتش', value: item.batch),
                _DetailLine(label: 'تاريخ الانتهاء', value: item.expiryDate),
                _DetailLine(label: 'نوع التغليف', value: item.packageType),
                _DetailLine(label: 'لون التغليف', value: item.packageColor),
                _DetailLine(
                    label: 'الأبعاد',
                    value:
                        '${item.packageLength} × ${item.packageWidth} × ${item.packageHeight} سم'),
                _DetailLine(label: 'الوزن', value: '${item.packageWeight} كجم'),
                _DetailLine(label: 'الحجم', value: '${item.packageVolume} م³'),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('اغلاق'),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryStrip extends StatelessWidget {
  final int totalItems;
  final int expiringSoon;
  final int packageCount;

  const _SummaryStrip({
    required this.totalItems,
    required this.expiringSoon,
    required this.packageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'الإجمالي',
            value: totalItems.toString(),
            icon: Icons.inventory_2,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'تنتهي قريباً',
            value: expiringSoon.toString(),
            icon: Icons.warning_amber_rounded,
            color: AppColors.warning,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'أنواع التغليف',
            value: packageCount.toString(),
            icon: Icons.category_outlined,
            color: AppColors.success,
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

class _InventoryRow extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback onTap;

  const _InventoryRow({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withValues(alpha: 0.16),
        child: const Icon(Icons.inventory_2, color: AppColors.primary),
      ),
      title:
          Text(item.sku, style: const TextStyle(color: AppColors.textPrimary)),
      subtitle: Text(
        '${item.packageType} • باتش ${item.batch} • ${item.expiryDate}',
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: Chip(
        label: Text(item.packageType),
        backgroundColor: AppColors.primary.withValues(alpha: 0.08),
        labelStyle: const TextStyle(color: AppColors.primary),
      ),
    );
  }
}

class _InventoryDetailPanel extends StatelessWidget {
  final InventoryItem? item;

  const _InventoryDetailPanel({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: const Center(
          child: Text(
            'اختر صنفاً لعرض التفاصيل',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تفاصيل الصنف',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _DetailLine(label: 'SKU', value: item!.sku),
          _DetailLine(label: 'باركود', value: item!.barcode),
          _DetailLine(label: 'باتش', value: item!.batch),
          _DetailLine(label: 'تاريخ الانتهاء', value: item!.expiryDate),
          _DetailLine(label: 'نوع التخزين', value: item!.packageType),
          _DetailLine(label: 'لون التغليف', value: item!.packageColor),
          _DetailLine(
            label: 'الأبعاد',
            value:
                '${item!.packageLength} × ${item!.packageWidth} × ${item!.packageHeight} سم',
          ),
          _DetailLine(label: 'الوزن', value: '${item!.packageWeight} كجم'),
          _DetailLine(label: 'الحجم', value: '${item!.packageVolume} م³'),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.qr_code),
            label: const Text('مسح QR'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(color: AppColors.textSecondary)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(color: AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }
}

class _EmptyInventory extends StatelessWidget {
  const _EmptyInventory();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2, color: AppColors.textSecondary, size: 60),
          SizedBox(height: 16),
          Text(
            'لا توجد أصناف مطابقة',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
