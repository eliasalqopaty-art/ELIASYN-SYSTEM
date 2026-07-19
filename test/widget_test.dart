import 'package:alasim_management/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Alasim app starts successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AlasimApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AlasimApp), findsOneWidget);
  });
}
