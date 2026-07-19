import 'package:flutter/material.dart';

class PharmaciesScreen extends StatelessWidget {
  const PharmaciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pharmacies')),
      body: const Center(
        child: Text('Clean Architecture placeholder for Pharmacies'),
      ),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
