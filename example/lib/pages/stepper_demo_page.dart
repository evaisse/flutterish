import 'package:flutter/material.dart' hide StepState, StepperType;
import 'package:flutterish/flutterish.dart';

import '../stories/account_setup_stepper.dart';

class StepperDemoPage extends StatefulWidget {
  const StepperDemoPage({super.key});

  @override
  State<StepperDemoPage> createState() => _StepperDemoPageState();
}

class _StepperDemoPageState extends State<StepperDemoPage> {
  int currentStep = 1;
  StepperType stepperType = StepperType.vertical;

  void _goToPreviousStep() {
    setState(() {
      currentStep = (currentStep - 1).clamp(0, AccountSetupStepper.stepsCount - 1);
    });
  }

  void _goToNextStep() {
    setState(() {
      currentStep = (currentStep + 1).clamp(0, AccountSetupStepper.stepsCount - 1);
    });
  }

  void _setStep(int step) {
    setState(() {
      currentStep = step;
    });
  }

  void _toggleLayout() {
    setState(() {
      stepperType = stepperType == StepperType.vertical
          ? StepperType.horizontal
          : StepperType.vertical;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutterish Stepper Demo'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Demo'),
              Tab(text: 'Setup Story'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                stepperType == StepperType.vertical
                    ? Icons.view_list
                    : Icons.view_column,
              ),
              onPressed: _toggleLayout,
              tooltip: 'Toggle Layout',
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _DemoTab(
              currentStep: currentStep,
              stepperType: stepperType,
              onPrevious: currentStep > 0 ? _goToPreviousStep : null,
              onNext: currentStep < AccountSetupStepper.stepsCount - 1
                  ? _goToNextStep
                  : null,
              onStepTapped: _setStep,
            ),
            const _StoryPreviewTab(),
          ],
        ),
      ),
    );
  }
}

class _DemoTab extends StatelessWidget {
  const _DemoTab({
    required this.currentStep,
    required this.stepperType,
    required this.onPrevious,
    required this.onNext,
    required this.onStepTapped,
  });

  final int currentStep;
  final StepperType stepperType;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<int> onStepTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onPrevious,
                child: const Text('Previous'),
              ),
              Text('Step ${currentStep + 1} of ${AccountSetupStepper.stepsCount}'),
              ElevatedButton(
                onPressed: onNext,
                child: const Text('Next'),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: AccountSetupStepper(
            currentStep: currentStep,
            type: stepperType,
            onStepTapped: onStepTapped,
          ),
        ),
      ],
    );
  }
}

class _StoryPreviewTab extends StatelessWidget {
  const _StoryPreviewTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: const AccountSetupStepper(
          currentStep: 1,
          type: StepperType.vertical,
        ),
      ),
    );
  }
}
