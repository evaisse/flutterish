import 'package:flutter/material.dart' hide StepState, StepperType;

import 'pages/stepper_demo_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterish Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const StepperDemoPage(),
    );
  }
}
