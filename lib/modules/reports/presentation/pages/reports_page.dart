import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String _period = 'هذا الشهر';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('التقارير والإحصائيات'),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _period,
                dropdownColor: AppColors.surface,
                style: const TextStyle(color: AppColors.textPrimary),
                items: const [
                  DropdownMenuItem(value: 'اليوم', child: Text('اليوم')),
                  DropdownMenuItem(
                    value: 'هذا الأسبوع',
                    child: Text('هذا الأسبوع'),
                  ),
                  DropdownMenuItem(
                    value: 'هذا الشهر',
                    child: Text('هذا الشهر'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _period = value);
                },
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: _exportReport,
              icon: const Icon(Icons.download),
              label: const Text('تصدير التقرير'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: const BorderSide(color: AppColors.border),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: _KpiCard(
                      label: 'إجمالي المبيعات',
                      value: '12.8M',
                      suffix: 'ريال',
                      icon: Icons.payments_outlined,
                      color: AppColors.success,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _KpiCard(
                      label: 'طلبات منفذة',
                      value: '486',
                      suffix: 'طلب',
                      icon: Icons.receipt_long,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _KpiCard(
                      label: 'تحصيلات',
                      value: '8.4M',
                      suffix: 'ريال',
                      icon: Icons.account_balance_wallet_outlined,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _KpiCard(
                      label: 'نواقص حرجة',
                      value: '23',
                      suffix: 'صنف',
                      icon: Icons.warning_amber,
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _ChartPanel(period: _period),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(child: _ReportList()),
                ],
              ),
              const SizedBox(height: 20),
              const _AlertsTable(),
            ],
          ),
        ),
      ),
    );
  }

  void _exportReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم تجهيز تقرير $_period للتصدير')),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final String suffix;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.suffix,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Icon(icon, color: color, size: 22),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  suffix,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartPanel extends StatelessWidget {
  final String period;

  const _ChartPanel({required this.period});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اتجاه المبيعات - $period',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          const Expanded(child: _SalesSparkline()),
        ],
      ),
    );
  }
}

class _SalesSparkline extends StatelessWidget {
  const _SalesSparkline();

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: _SalesSparklinePainter(
        values: [3, 4.5, 4, 6.8, 6.2, 8, 9.4],
      ),
      child: SizedBox.expand(),
    );
  }
}

class _SalesSparklinePainter extends CustomPainter {
  final List<double> values;

  const _SalesSparklinePainter({required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final fillPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    for (var i = 1; i <= 4; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (var i = 1; i <= values.length - 1; i++) {
      final x = size.width * i / (values.length - 1);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final minValue = values.reduce((a, b) => a < b ? a : b);
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final range = maxValue - minValue == 0 ? 1 : maxValue - minValue;

    Offset pointAt(int index) {
      final x = size.width * index / (values.length - 1);
      final normalized = (values[index] - minValue) / range;
      final y = size.height - (normalized * size.height * 0.82) - 12;
      return Offset(x, y);
    }

    final linePath = Path()..moveTo(pointAt(0).dx, pointAt(0).dy);
    for (var i = 1; i < values.length; i++) {
      linePath.lineTo(pointAt(i).dx, pointAt(i).dy);
    }

    final fillPath = Path.from(linePath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    final dotPaint = Paint()..color = AppColors.primary;
    for (var i = 0; i < values.length; i++) {
      canvas.drawCircle(pointAt(i), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SalesSparklinePainter oldDelegate) {
    return oldDelegate.values != values;
  }
}

class _ReportList extends StatelessWidget {
  const _ReportList();

  @override
  Widget build(BuildContext context) {
    final reports = [
      ('مبيعات حسب المنطقة', Icons.map_outlined, AppColors.primary),
      ('حركة المخزون', Icons.inventory_2_outlined, AppColors.warning),
      ('أداء المندوبين', Icons.groups_outlined, AppColors.success),
      (
        'المديونيات والتحصيل',
        Icons.account_balance_outlined,
        AppColors.secondary
      ),
      ('الأصناف الراكدة', Icons.hourglass_empty, AppColors.danger),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تقارير جاهزة',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          for (final report in reports)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(report.$2, color: report.$3),
              title: Text(
                report.$1,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
              trailing: const Icon(
                Icons.chevron_left,
                color: AppColors.textSecondary,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تم فتح ${report.$1}')),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _AlertsTable extends StatelessWidget {
  const _AlertsTable();

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('أموكسيسيلين 250mg', 'مخزن الجنوب', 'منخفض', '118'),
      ('شراب كحة للأطفال', 'المخزن المركزي', 'قرب انتهاء', '72'),
      ('حقن فيتامين B12', 'مخزن المرتجعات', 'جرد مطلوب', '36'),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تنبيهات تحتاج إجراء',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          DataTable(
            columns: const [
              DataColumn(label: Text('الصنف')),
              DataColumn(label: Text('الموقع')),
              DataColumn(label: Text('الحالة')),
              DataColumn(label: Text('الكمية')),
            ],
            rows: [
              for (final row in rows)
                DataRow(
                  cells: [
                    DataCell(Text(row.$1)),
                    DataCell(Text(row.$2)),
                    DataCell(Text(row.$3)),
                    DataCell(Text(row.$4)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
