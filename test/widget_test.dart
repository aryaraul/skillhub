import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skillhub/main.dart';

void main() {
  testWidgets('SkillHub renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SkillHubApp());

    // Check if "Login" text or button is present.
    expect(find.text('Login'), findsOneWidget);

    // Optional: Check for email and password fields
    expect(find.byType(TextField), findsNWidgets(2));

    // Optional: Check for "Sign Up" button if you're on the login screen
    expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
  });
}
