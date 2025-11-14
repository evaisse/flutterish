import 'package:flutter/material.dart' hide StepState, StepperType;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish/flutterish.dart';

void main() {
  group('Stepper Widget Tests', () {
    testWidgets('FlutterishStepper displays steps correctly', (WidgetTester tester) async {
      final steps = [
        const StepperStep(
          title: Text('Step 1'),
          content: Text('Content 1'),
        ),
        const StepperStep(
          title: Text('Step 2'),
          content: Text('Content 2'),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterishStepper(
              steps: steps,
              currentStep: 0,
            ),
          ),
        ),
      );

      expect(find.text('Step 1'), findsOneWidget);
      expect(find.text('Step 2'), findsOneWidget);
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsNothing); // Only active step shows content
    });

    testWidgets('FlutterishStepper handles step tapping', (WidgetTester tester) async {
      int tappedStep = -1;
      final steps = [
        const StepperStep(title: Text('Step 1')),
        const StepperStep(title: Text('Step 2')),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterishStepper(
              steps: steps,
              currentStep: 0,
              onStepTapped: (step) {
                tappedStep = step;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Step 2'));
      expect(tappedStep, equals(1));
    });

    testWidgets('FlutterishStepper shows horizontal layout', (WidgetTester tester) async {
      final steps = [
        const StepperStep(title: Text('Step 1')),
        const StepperStep(title: Text('Step 2')),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterishStepper(
              steps: steps,
              type: StepperType.horizontal,
            ),
          ),
        ),
      );

      expect(find.byType(Row), findsWidgets);
      expect(find.text('Step 1'), findsOneWidget);
      expect(find.text('Step 2'), findsOneWidget);
    });

    testWidgets('FlutterishStepper displays different step states', (WidgetTester tester) async {
      final steps = [
        const StepperStep(
          title: Text('Complete Step'),
          state: StepState.complete,
        ),
        const StepperStep(
          title: Text('Error Step'),
          state: StepState.error,
        ),
        const StepperStep(
          title: Text('Disabled Step'),
          state: StepState.disabled,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterishStepper(steps: steps),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.text('Complete Step'), findsOneWidget);
      expect(find.text('Error Step'), findsOneWidget);
      expect(find.text('Disabled Step'), findsOneWidget);
    });
  });

  group('StepperStep Tests', () {
    test('StepperStep copyWith works correctly', () {
      const originalStep = StepperStep(
        title: Text('Original'),
        state: StepState.indexed,
      );

      final copiedStep = originalStep.copyWith(
        state: StepState.complete,
      );

      expect(copiedStep.state, equals(StepState.complete));
      expect(copiedStep.title, equals(originalStep.title));
    });

    test('StepperStep equality works correctly', () {
      const step1 = StepperStep(title: Text('Step'));
      const step2 = StepperStep(title: Text('Step'));
      const step3 = StepperStep(title: Text('Different'));

      expect(step1, equals(step2));
      expect(step1, isNot(equals(step3)));
    });
  });

  group('StepperTheme Tests', () {
    testWidgets('StepperTheme provides theme data', (WidgetTester tester) async {
      const themeData = StepperThemeData(
        activeStepColor: Colors.red,
      );

      late StepperThemeData retrievedTheme;

      await tester.pumpWidget(
        MaterialApp(
          home: StepperTheme(
            data: themeData,
            child: Builder(
              builder: (context) {
                retrievedTheme = StepperTheme.of(context);
                return Container();
              },
            ),
          ),
        ),
      );

      expect(retrievedTheme.activeStepColor, equals(Colors.red));
    });

    test('StepperThemeData copyWith works correctly', () {
      const originalTheme = StepperThemeData(
        activeStepColor: Colors.blue,
        iconSize: 24.0,
      );

      final copiedTheme = originalTheme.copyWith(
        activeStepColor: Colors.red,
      );

      expect(copiedTheme.activeStepColor, equals(Colors.red));
      expect(copiedTheme.iconSize, equals(24.0));
    });

    test('StepperThemeData lerp works correctly', () {
      const themeA = StepperThemeData(
        iconSize: 20.0,
        elevation: 0.0,
      );
      const themeB = StepperThemeData(
        iconSize: 30.0,
        elevation: 4.0,
      );

      final lerpedTheme = StepperThemeData.lerp(themeA, themeB, 0.5);

      expect(lerpedTheme.iconSize, equals(25.0));
      expect(lerpedTheme.elevation, equals(2.0));
    });
  });
}
