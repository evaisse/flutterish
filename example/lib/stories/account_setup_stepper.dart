import 'package:flutter/material.dart' hide StepState, StepperType;
import 'package:flutterish/flutterish.dart';

/// A reusable story that showcases the account setup flow using [FlutterishStepper].
class AccountSetupStepper extends StatelessWidget {
  const AccountSetupStepper({
    super.key,
    this.currentStep = 1,
    this.type = StepperType.vertical,
    this.onStepTapped,
    this.completedProgress = true,
    this.theme,
  });

  /// Zero-based index of the active step.
  final int currentStep;

  /// Layout direction for the stepper.
  final StepperType type;

  /// Optional callback when a step is touched.
  final ValueChanged<int>? onStepTapped;

  /// Whether steps prior to the current one should appear as completed.
  final bool completedProgress;

  /// Optional override for the theme; falls back to [defaultTheme].
  final StepperThemeData? theme;

  /// Authoritative definition of the account setup steps.
  static const List<StepperStep> baseSteps = [
    StepperStep(
      title: Text('Account Setup'),
      subtitle: Text('Create your account'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please fill in your account details:'),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
      state: StepState.indexed,
    ),
    StepperStep(
      title: Text('Profile Information'),
      subtitle: Text('Tell us about yourself'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter your profile information:'),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      state: StepState.indexed,
    ),
    StepperStep(
      title: Text('Verification'),
      subtitle: Text('Verify your account'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please verify your email address:'),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Verification Code',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      state: StepState.indexed,
    ),
    StepperStep(
      title: Text('Complete'),
      subtitle: Text('All done!'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 48),
          SizedBox(height: 8),
          Text('Your account has been successfully created!'),
        ],
      ),
      state: StepState.complete,
    ),
  ];

  /// Convenience accessor for the number of steps.
  static int get stepsCount => baseSteps.length;

  /// Default theme that mirrors the interactive demo styling.
  static StepperThemeData defaultTheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return StepperThemeData(
      activeStepColor: colorScheme.primary,
      completeStepColor: Colors.green,
      errorStepColor: Colors.red,
      editingStepColor: Colors.orange,
      connectorColor: Colors.grey.shade300,
      activeStepTitleStyle: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
      stepPadding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      elevation: 2.0,
    );
  }

  List<StepperStep> _buildSteps(int activeStep) {
    if (!completedProgress) {
      return baseSteps;
    }

    return List<StepperStep>.generate(baseSteps.length, (index) {
      final step = baseSteps[index];
      if (index < activeStep) {
        return step.copyWith(state: StepState.complete);
      }
      if (index == activeStep) {
        return step.copyWith(state: StepState.editing);
      }
      return step.copyWith(state: StepState.indexed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final normalizedStep = currentStep.clamp(0, baseSteps.length - 1);
    return StepperTheme(
      data: theme ?? defaultTheme(context),
      child: FlutterishStepper(
        steps: _buildSteps(normalizedStep),
        currentStep: normalizedStep,
        type: type,
        onStepTapped: onStepTapped,
      ),
    );
  }
}
