import 'package:flutter/material.dart' hide StepState, StepperType;

import 'pages/stepper_demo_page.dart';
import 'pages/a2ui_demo_page.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutterish Examples')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Stepper Component'),
            subtitle: const Text('Vertical and Horizontal Steppers'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StepperDemoPage()),
              );
            },
            trailing: const Icon(Icons.arrow_forward),
          ),
          ListTile(
            title: const Text('A2UI Client'),
            subtitle: const Text('Mock A2UI Stream Renderer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const A2UIDemoPage()),
              );
            },
            trailing: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
