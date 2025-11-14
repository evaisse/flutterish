import 'package:flutter/material.dart' hide StepState, StepperType;
import 'stepper_step.dart';
import 'stepper_theme.dart';

/// A widget that displays a sequence of steps to guide users through a process.
///
/// The stepper shows the progress of each step and allows navigation between steps.
/// It supports both vertical and horizontal layouts with customizable styling.
class FlutterishStepper extends StatefulWidget {
  /// Creates a stepper widget.
  ///
  /// The [steps] parameter must not be empty.
  const FlutterishStepper({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.onStepTapped,
    this.type = StepperType.vertical,
    this.controlsBuilder,
    this.physics,
    this.margin,
    this.elevation,
  }) : assert(currentStep >= 0);

  /// The list of steps to display.
  final List<StepperStep> steps;

  /// The index of the currently active step.
  final int currentStep;

  /// Called when a step is tapped.
  final ValueChanged<int>? onStepTapped;

  /// Whether the stepper is displayed vertically or horizontally.
  final StepperType type;

  /// Builder for custom step controls.
  final ControlsBuilder? controlsBuilder;

  /// The scroll physics for the stepper.
  final ScrollPhysics? physics;

  /// The margin around the stepper content.
  final EdgeInsets? margin;

  /// The elevation of the stepper.
  final double? elevation;

  @override
  State<FlutterishStepper> createState() => _FlutterishStepperState();
}

class _FlutterishStepperState extends State<FlutterishStepper> {
  @override
  Widget build(BuildContext context) {
    final theme = StepperTheme.of(context);
    
    return Material(
      elevation: widget.elevation ?? theme.elevation,
      child: Container(
        margin: widget.margin ?? theme.margin,
        child: widget.type == StepperType.vertical
            ? _buildVerticalStepper(theme)
            : _buildHorizontalStepper(theme),
      ),
    );
  }

  Widget _buildVerticalStepper(StepperThemeData theme) {
    return ListView.builder(
      physics: widget.physics,
      itemCount: widget.steps.length,
      itemBuilder: (context, index) {
        final step = widget.steps[index];
        final isActive = index == widget.currentStep;
        final isLast = index == widget.steps.length - 1;

        return Column(
          children: [
            _buildStepItem(step, index, isActive, theme),
            if (!isLast) _buildConnector(theme),
          ],
        );
      },
    );
  }

  Widget _buildHorizontalStepper(StepperThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: widget.physics,
      child: Row(
        children: [
          for (int i = 0; i < widget.steps.length; i++) ...[
            _buildStepItem(widget.steps[i], i, i == widget.currentStep, theme),
            if (i < widget.steps.length - 1)
              _buildHorizontalConnector(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildStepItem(StepperStep step, int index, bool isActive, StepperThemeData theme) {
    return InkWell(
      onTap: widget.onStepTapped != null ? () => widget.onStepTapped!(index) : null,
      borderRadius: BorderRadius.circular(8),
      child: Semantics(
        button: widget.onStepTapped != null,
        selected: isActive,
        child: Container(
          padding: theme.stepPadding,
          child: widget.type == StepperType.vertical
              ? _buildVerticalStepContent(step, index, isActive, theme)
              : _buildHorizontalStepContent(step, index, isActive, theme),
        ),
      ),
    );
  }

  Widget _buildVerticalStepContent(StepperStep step, int index, bool isActive, StepperThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepIcon(step, index, isActive, theme),
        SizedBox(width: theme.iconSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: (isActive ? theme.activeStepTitleStyle : theme.inactiveStepTitleStyle) ?? 
                       Theme.of(context).textTheme.titleMedium!,
                child: step.title,
              ),
              if (step.subtitle != null) ...[
                const SizedBox(height: 4),
                DefaultTextStyle(
                  style: theme.stepSubtitleStyle ?? Theme.of(context).textTheme.bodySmall!,
                  child: step.subtitle!,
                ),
              ],
              if (step.content != null && isActive) ...[
                const SizedBox(height: 8),
                step.content!,
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalStepContent(StepperStep step, int index, bool isActive, StepperThemeData theme) {
    return Column(
      children: [
        _buildStepIcon(step, index, isActive, theme),
        const SizedBox(height: 8),
        DefaultTextStyle(
          style: (isActive ? theme.activeStepTitleStyle : theme.inactiveStepTitleStyle) ?? 
                 Theme.of(context).textTheme.titleSmall!,
          child: step.title,
        ),
        if (step.subtitle != null)
          DefaultTextStyle(
            style: theme.stepSubtitleStyle ?? Theme.of(context).textTheme.bodySmall!,
            child: step.subtitle!,
          ),
      ],
    );
  }

  Widget _buildStepIcon(StepperStep step, int index, bool isActive, StepperThemeData theme) {
    Color backgroundColor;
    Color foregroundColor;
    Widget iconChild;

    switch (step.state) {
      case StepState.complete:
        backgroundColor = theme.completeStepColor ?? Colors.green;
        foregroundColor = Colors.white;
        iconChild = const Icon(Icons.check, size: 16);
        break;
      case StepState.error:
        backgroundColor = theme.errorStepColor ?? Colors.red;
        foregroundColor = Colors.white;
        iconChild = const Icon(Icons.close, size: 16);
        break;
      case StepState.disabled:
        backgroundColor = theme.disabledStepColor ?? Colors.grey.shade300;
        foregroundColor = Colors.grey.shade600;
        iconChild = Text('${index + 1}', style: const TextStyle(fontSize: 12));
        break;
      case StepState.editing:
        backgroundColor = theme.editingStepColor ?? Colors.blue;
        foregroundColor = Colors.white;
        iconChild = const Icon(Icons.edit, size: 16);
        break;
      case StepState.indexed:
        backgroundColor = isActive 
            ? (theme.activeStepColor ?? Theme.of(context).primaryColor)
            : (theme.inactiveStepColor ?? Colors.grey.shade300);
        foregroundColor = isActive ? Colors.white : Colors.grey.shade600;
        iconChild = Text('${index + 1}', style: const TextStyle(fontSize: 12));
        break;
    }

    return Semantics(
      label: 'Step ${index + 1}${step.state == StepState.complete ? ', completed' : ''}${step.state == StepState.error ? ', has error' : ''}',
      child: Container(
        width: theme.iconSize,
        height: theme.iconSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: isActive ? Border.all(color: Theme.of(context).primaryColor, width: 2) : null,
        ),
        child: Center(
          child: IconTheme(
            data: IconThemeData(color: foregroundColor),
            child: DefaultTextStyle(
              style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold),
              child: iconChild,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnector(StepperThemeData theme) {
    return Container(
      width: 2,
      height: theme.connectorHeight,
      margin: EdgeInsets.only(left: theme.iconSize / 2 - 1),
      color: theme.connectorColor ?? Colors.grey.shade300,
    );
  }

  Widget _buildHorizontalConnector(StepperThemeData theme) {
    return Container(
      width: theme.connectorHeight,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: theme.connectorColor ?? Colors.grey.shade300,
    );
  }
}

/// The type of stepper layout.
enum StepperType {
  /// Display steps vertically.
  vertical,
  
  /// Display steps horizontally.
  horizontal,
}

/// A builder for custom step controls.
typedef ControlsBuilder = Widget Function(BuildContext context, ControlsDetails details);

/// Details for the controls builder.
class ControlsDetails {
  /// Creates controls details.
  const ControlsDetails({
    required this.stepIndex,
    required this.isActive,
    this.onStepCancel,
    this.onStepContinue,
  });

  /// The index of the step.
  final int stepIndex;
  
  /// Whether this step is currently active.
  final bool isActive;
  
  /// Callback for cancel action.
  final VoidCallback? onStepCancel;
  
  /// Callback for continue action.
  final VoidCallback? onStepContinue;
}