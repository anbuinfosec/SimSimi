// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sim_simi/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SimiApp());

    // Verify that the app starts with Chat screen
    expect(find.text('Simi'), findsOneWidget);

    // Verify bottom navigation exists
    expect(find.byType(NavigationBar), findsOneWidget);

    // Verify all three navigation destinations
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Teach'), findsOneWidget);
    expect(find.text('Developer'), findsOneWidget);
  });

  testWidgets('Navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(const SimiApp());

    // Tap on Teach tab
    await tester.tap(find.text('Teach'));
    await tester.pumpAndSettle();
    expect(find.text('Teach Simi'), findsAtLeastNWidgets(1));

    // Tap on Developer tab
    await tester.tap(find.text('Developer'));
    await tester.pumpAndSettle();
    expect(find.text('Developer'), findsAtLeastNWidgets(1));

    // Go back to Chat tab
    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();
    expect(find.text('Simi'), findsAtLeastNWidgets(1));
  });
}
