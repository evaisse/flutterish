import 'package:flutter/material.dart' hide StepState, StepperType;
import 'package:flutterish/flutterish.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stories/account_setup_stepper.dart';

void main() {
  runApp(const FlutterishWidgetbook());
}

class FlutterishWidgetbook extends StatelessWidget {
  const FlutterishWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appBuilder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        home: Scaffold(body: Center(child: child)),
      ),
      directories: [
        WidgetbookCategory(
          name: 'Components',
          children: [
            WidgetbookComponent(
              name: 'Stepper',
              useCases: [
                WidgetbookUseCase(
                  name: 'Account Setup Story',
                  builder: (context) => Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: const AccountSetupStepper(
                        currentStep: 1,
                        type: StepperType.vertical,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
