import 'package:flutter/material.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Branches')),
      body: const Center(
        child: Text('Clean Architecture placeholder for Branches'),
      ),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
