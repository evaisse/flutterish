import 'package:flutter/material.dart' hide StepState, StepperType;
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterish/flutterish.dart';
import 'package:flutterish_dmeo/stories/account_setup_stepper.dart';

void main() {
  testWidgets('renders account setup story content', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AccountSetupStepper(currentStep: 1),
        ),
      ),
    );

    expect(find.text('Account Setup'), findsOneWidget);
    expect(find.text('Profile Information'), findsOneWidget);
    expect(find.text('Verification'), findsOneWidget);
  });

  testWidgets('supports horizontal layout for account setup story', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AccountSetupStepper(
            currentStep: 2,
            type: StepperType.horizontal,
          ),
        ),
      ),
    );

    expect(find.byType(Row), findsWidgets);
    expect(find.text('Complete'), findsOneWidget);
  });
}
