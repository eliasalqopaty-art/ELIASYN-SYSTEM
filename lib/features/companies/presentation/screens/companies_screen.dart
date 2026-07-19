import 'package:flutter/material.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Companies')),
      body: const Center(
        child: Text('Clean Architecture placeholder for Companies'),
      ),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
