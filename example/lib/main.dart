import 'package:flutter/material.dart';
import 'package:flutterish/flutterish.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterish Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StepperDemoPage(),
    );
  }
}

class StepperDemoPage extends StatefulWidget {
  const StepperDemoPage({super.key});

  @override
  State<StepperDemoPage> createState() => _StepperDemoPageState();
}

class _StepperDemoPageState extends State<StepperDemoPage> {
  int currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  final List<StepperStep> steps = [
    StepperStep(
      title: const Text('Account Setup'),
      subtitle: const Text('Create your account'),
      content: const Column(
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
      title: const Text('Profile Information'),
      subtitle: const Text('Tell us about yourself'),
      content: const Column(
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
      title: const Text('Verification'),
      subtitle: const Text('Verify your account'),
      content: const Column(
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
      state: StepState.complete,
    ),
    StepperStep(
      title: const Text('Complete'),
      subtitle: const Text('All done!'),
      content: const Column(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutterish Stepper Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(stepperType == StepperType.vertical 
                ? Icons.view_list 
                : Icons.view_column),
            onPressed: () {
              setState(() {
                stepperType = stepperType == StepperType.vertical 
                    ? StepperType.horizontal 
                    : StepperType.vertical;
              });
            },
            tooltip: 'Toggle Layout',
          ),
        ],
      ),
      body: StepperTheme(
        data: StepperThemeData(
          activeStepColor: Theme.of(context).primaryColor,
          completeStepColor: Colors.green,
          errorStepColor: Colors.red,
          editingStepColor: Colors.orange,
          connectorColor: Colors.grey.shade300,
          activeStepTitleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          stepPadding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          elevation: 2.0,
        ),
        child: Column(
          children: [
            // Demo controls
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: currentStep > 0 ? () {
                      setState(() {
                        currentStep--;
                      });
                    } : null,
                    child: const Text('Previous'),
                  ),
                  Text('Step ${currentStep + 1} of ${steps.length}'),
                  ElevatedButton(
                    onPressed: currentStep < steps.length - 1 ? () {
                      setState(() {
                        currentStep++;
                      });
                    } : null,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Stepper widget
            Expanded(
              child: FlutterishStepper(
                steps: steps,
                currentStep: currentStep,
                type: stepperType,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
