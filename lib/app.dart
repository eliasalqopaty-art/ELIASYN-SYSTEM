import 'package:flutter/material.dart';

import 'core/router/app_router.dart';

class AlasimApp extends StatelessWidget {
  const AlasimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
