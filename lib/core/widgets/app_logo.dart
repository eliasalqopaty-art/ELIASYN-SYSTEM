import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.compact = false,
    this.showSubtitle = true,
  });

  final bool compact;
  final bool showSubtitle;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 26.0 : 34.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'eliasyn',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: compact ? 13 : 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showSubtitle)
                Text(
                  'ثقة اليوم ... استدامة الغد',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: compact ? 10 : 11,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppWatermark extends StatelessWidget {
  const AppWatermark({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      child: Center(
        child: Opacity(
          opacity: 0.18,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 18,
                height: 18,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 6),
              const Text(
                'eliasyn • ثقة اليوم ... استدامة الغد',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
