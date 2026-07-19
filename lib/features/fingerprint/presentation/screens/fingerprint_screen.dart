import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class FingerprintScreen extends StatelessWidget {
  const FingerprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('Fingerprint & Biometric Placeholder'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('التحقق البيومتري (بدون SDK حاليًا)',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                  'هذه نسخة تجريبية فقط لاستخدام placeholder حتى يتم ربط SDK حقيقي لاحقًا.',
                  style: TextStyle(color: AppColors.textSecondary)),
              SizedBox(height: 18),
              _BiometricCard(
                  title: 'Fingerprint Placeholder',
                  subtitle: 'تحقق بالبصمة',
                  icon: Icons.fingerprint),
              SizedBox(height: 10),
              _BiometricCard(
                  title: 'Face Authentication Placeholder',
                  subtitle: 'تحقق بالوجه',
                  icon: Icons.face_retouching_natural),
              SizedBox(height: 10),
              _BiometricCard(
                  title: 'Voice Authentication Placeholder',
                  subtitle: 'تحقق بالصوت',
                  icon: Icons.mic),
            ],
          ),
        ),
      ),
    );
  }
}

class _BiometricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _BiometricCard(
      {required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border)),
      child: Row(children: [
        CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: Icon(icon, color: AppColors.primary)),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: AppColors.textSecondary)),
        ])),
        const Icon(Icons.arrow_back_ios_new,
            color: AppColors.textSecondary, size: 16),
      ]),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
