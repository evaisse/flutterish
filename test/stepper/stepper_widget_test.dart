import 'package:flutter/material.dart' hide StepState, StepperType;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish/flutterish.dart';

void main() {
  group('FlutterishStepper Widget Tests', () {
    testWidgets('displays vertical stepper correctly', (WidgetTester tester) async {
      final steps = [
        const StepperStep(
          title: Text('Step 1'),
          subtitle: Text('First step'),
          content: Text('Step 1 content'),
        ),
        const StepperStep(
          title: Text('Step 2'),
          subtitle: Text('Second step'),
          content: Text('Step 2 content'),
          state: StepState.complete,
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

      // Check that steps are displayed
      expect(find.text('Step 1'), findsOneWidget);
      expect(find.text('Step 2'), findsOneWidget);
      expect(find.text('First step'), findsOneWidget);
      expect(find.text('Second step'), findsOneWidget);
      
      // Only active step should show content in vertical mode
      expect(find.text('Step 1 content'), findsOneWidget);
      expect(find.text('Step 2 content'), findsNothing);
      
      // Check for completion icon
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('displays horizontal stepper correctly', (WidgetTester tester) async {
      final steps = [
        const StepperStep(title: Text('Step 1')),
        const StepperStep(title: Text('Step 2')),
        const StepperStep(title: Text('Step 3')),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterishStepper(
              steps: steps,
              type: StepperType.horizontal,
              currentStep: 1,
            ),
          ),
        ),
      );

      expect(find.text('Step 1'), findsOneWidget);
      expect(find.text('Step 2'), findsOneWidget);
      expect(find.text('Step 3'), findsOneWidget);
      
      // Should find horizontal layout components
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('handles step tapping correctly', (WidgetTester tester) async {
      int? tappedStep;
      final steps = [
        const StepperStep(title: Text('Step 1')),
        const StepperStep(title: Text('Step 2')),
        const StepperStep(title: Text('Step 3')),
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

      // Tap on step 2
      await tester.tap(find.text('Step 2'));
      await tester.pump();

      expect(tappedStep, equals(1));
    });

    testWidgets('applies custom theme correctly', (WidgetTester tester) async {
      const customTheme = StepperThemeData(
        activeStepColor: Colors.red,
        iconSize: 32.0,
        elevation: 4.0,
      );

      final steps = [
        const StepperStep(title: Text('Step 1')),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StepperTheme(
              data: customTheme,
              child: FlutterishStepper(
                steps: steps,
                currentStep: 0,
              ),
            ),
          ),
        ),
      );

      // Widget should render without errors with custom theme
      expect(find.text('Step 1'), findsOneWidget);
      
      // Find the Material widget within the FlutterishStepper to check elevation
      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(FlutterishStepper),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, equals(4.0));
    });

    testWidgets('shows correct step states', (WidgetTester tester) async {
      final steps = [
        const StepperStep(
          title: Text('Complete'),
          state: StepState.complete,
        ),
        const StepperStep(
          title: Text('Error'),
          state: StepState.error,
        ),
        const StepperStep(
          title: Text('Editing'),
          state: StepState.editing,
        ),
        const StepperStep(
          title: Text('Disabled'),
          state: StepState.disabled,
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

      expect(find.byIcon(Icons.check), findsOneWidget); // Complete
      expect(find.byIcon(Icons.close), findsOneWidget); // Error
      expect(find.byIcon(Icons.edit), findsOneWidget); // Editing
      expect(find.text('4'), findsOneWidget); // Disabled shows number
    });

    testWidgets('provides proper semantics for accessibility', (WidgetTester tester) async {
      final steps = [
        const StepperStep(
          title: Text('Step 1'),
          state: StepState.complete,
        ),
        const StepperStep(
          title: Text('Step 2'),
          state: StepState.error,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterishStepper(
              steps: steps,
              currentStep: 0,
              onStepTapped: (step) {},
            ),
          ),
        ),
      );

      // Check semantics for completed step (has check icon, not text)
      expect(
        tester.getSemantics(find.byIcon(Icons.check)),
        matchesSemantics(
          label: 'Step 1, completed',
        ),
      );

      // Check semantics for error step (has close icon, not text)
      expect(
        tester.getSemantics(find.byIcon(Icons.close)),
        matchesSemantics(
          label: 'Step 2, has error',
        ),
      );
    });

    testWidgets('handles empty steps list gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterishStepper(
              steps: [],
            ),
          ),
        ),
      );

      // Should not crash and should render empty list
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('respects currentStep bounds', (WidgetTester tester) async {
      final steps = [
        const StepperStep(title: Text('Step 1')),
        const StepperStep(title: Text('Step 2')),
      ];

      // Test with currentStep beyond bounds
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterishStepper(
              steps: steps,
              currentStep: 5, // Beyond bounds
            ),
          ),
        ),
      );

      // Should not crash
      expect(find.text('Step 1'), findsOneWidget);
      expect(find.text('Step 2'), findsOneWidget);
    });
  });
}