import 'package:flutter/material.dart' hide StepState, StepperType;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish/flutterish.dart';

void main() {
  group('FlutterishStepper Golden Tests', () {
    testWidgets('vertical stepper with different states', (WidgetTester tester) async {
      final steps = [
        const StepperStep(
          title: Text('Account Setup'),
          subtitle: Text('Create your account'),
          content: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Fill in your account details to get started.'),
          ),
          state: StepState.complete,
        ),
        const StepperStep(
          title: Text('Profile Information'),
          subtitle: Text('Tell us about yourself'),
          content: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Enter your profile information.'),
          ),
          state: StepState.indexed,
        ),
        const StepperStep(
          title: Text('Verification'),
          subtitle: Text('Verify your account'),
          content: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Please verify your email address.'),
          ),
          state: StepState.error,
        ),
        const StepperStep(
          title: Text('Payment'),
          subtitle: Text('Choose your plan'),
          state: StepState.disabled,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: 400,
              height: 600,
              child: FlutterishStepper(
                steps: steps,
                currentStep: 1,
                type: StepperType.vertical,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(FlutterishStepper),
        matchesGoldenFile('goldens/vertical_stepper.png'),
      );
    });

    testWidgets('horizontal stepper', (WidgetTester tester) async {
      final steps = [
        const StepperStep(
          title: Text('Step 1'),
          subtitle: Text('First'),
          state: StepState.complete,
        ),
        const StepperStep(
          title: Text('Step 2'),
          subtitle: Text('Second'),
          state: StepState.indexed,
        ),
        const StepperStep(
          title: Text('Step 3'),
          subtitle: Text('Third'),
          state: StepState.indexed,
        ),
        const StepperStep(
          title: Text('Step 4'),
          subtitle: Text('Fourth'),
          state: StepState.disabled,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: 600,
              height: 200,
              child: FlutterishStepper(
                steps: steps,
                currentStep: 1,
                type: StepperType.horizontal,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(FlutterishStepper),
        matchesGoldenFile('goldens/horizontal_stepper.png'),
      );
    });

    testWidgets('themed stepper', (WidgetTester tester) async {
      final steps = [
        const StepperStep(
          title: Text('Custom Theme Step 1'),
          subtitle: Text('With custom colors'),
          content: Text('This stepper uses a custom theme.'),
          state: StepState.complete,
        ),
        const StepperStep(
          title: Text('Custom Theme Step 2'),
          subtitle: Text('Active step'),
          content: Text('Currently active step with custom styling.'),
          state: StepState.indexed,
        ),
        const StepperStep(
          title: Text('Custom Theme Step 3'),
          subtitle: Text('Error state'),
          state: StepState.error,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: 400,
              height: 500,
              child: StepperTheme(
                data: const StepperThemeData(
                  activeStepColor: Colors.purple,
                  completeStepColor: Colors.green,
                  errorStepColor: Colors.red,
                  connectorColor: Colors.purple,
                  iconSize: 28.0,
                  stepPadding: EdgeInsets.all(12.0),
                  elevation: 4.0,
                ),
                child: FlutterishStepper(
                  steps: steps,
                  currentStep: 1,
                  type: StepperType.vertical,
                ),
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(FlutterishStepper),
        matchesGoldenFile('goldens/themed_stepper.png'),
      );
    });
  });
}