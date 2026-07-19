import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: Text('Clean Architecture placeholder for Settings'),
      ),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
