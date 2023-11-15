import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/main.dart';
import 'package:calculator_app/pages/home_page.dart';

void main() {
  testWidgets('MyApp Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts with the HomePage.
    expect(find.byType(HomePage), findsOneWidget);
  });
}
