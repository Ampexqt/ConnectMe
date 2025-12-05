// This is a basic Flutter widget test.
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:connect_me/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ConnectMeApp());

    // Verify that the splash screen appears
    expect(find.text('ConnectMe'), findsOneWidget);
  });
}
