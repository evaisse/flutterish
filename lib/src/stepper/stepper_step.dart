import 'package:flutter/material.dart';

/// A single step in a stepper widget.
///
/// Contains the title, optional content, and state of the step.
class StepperStep {
  /// Creates a stepper step.
  ///
  /// The [title] is required and represents the main label for the step.
  const StepperStep({
    required this.title,
    this.content,
    this.subtitle,
    this.state = StepState.indexed,
    this.isActive = false,
    this.canTap = true,
  });

  /// The title widget for the step.
  /// 
  /// This is typically a [Text] widget but can be any widget.
  final Widget title;

  /// Optional content widget displayed when the step is active.
  /// 
  /// This is only shown in vertical stepper mode when the step is active.
  final Widget? content;

  /// Optional subtitle widget displayed below the title.
  final Widget? subtitle;

  /// The current state of the step.
  final StepState state;

  /// Whether this step is currently active.
  /// 
  /// Active steps may show additional content and have different styling.
  final bool isActive;

  /// Whether this step can be tapped to navigate to it.
  final bool canTap;

  /// Creates a copy of this step with the given fields replaced.
  StepperStep copyWith({
    Widget? title,
    Widget? content,
    Widget? subtitle,
    StepState? state,
    bool? isActive,
    bool? canTap,
  }) {
    return StepperStep(
      title: title ?? this.title,
      content: content ?? this.content,
      subtitle: subtitle ?? this.subtitle,
      state: state ?? this.state,
      isActive: isActive ?? this.isActive,
      canTap: canTap ?? this.canTap,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepperStep &&
        other.title == title &&
        other.content == content &&
        other.subtitle == subtitle &&
        other.state == state &&
        other.isActive == isActive &&
        other.canTap == canTap;
  }

  @override
  int get hashCode {
    return Object.hash(
      title,
      content,
      subtitle,
      state,
      isActive,
      canTap,
    );
  }

  @override
  String toString() {
    return 'StepperStep('
        'title: $title, '
        'content: $content, '
        'subtitle: $subtitle, '
        'state: $state, '
        'isActive: $isActive, '
        'canTap: $canTap'
        ')';
  }
}

/// The state of a step in the stepper.
enum StepState {
  /// The step displays a number indicating its position in the sequence.
  indexed,

  /// The step is currently being edited.
  editing,

  /// The step has been completed successfully.
  complete,

  /// The step is disabled and cannot be interacted with.
  disabled,

  /// The step has an error that needs to be resolved.
  error,
}