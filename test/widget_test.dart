import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vittaxia/app.dart';

void main() {
  testWidgets('App renders app bar title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: VittaxiaApp()),
    );
    await tester.pumpAndSettle();

    // AppBar 标题带空格
    expect(find.text('维 塔 侠'), findsOneWidget);
  });
}
