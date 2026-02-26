import 'package:flutter/material.dart';

/// Theme data for customizing the appearance of stepper widgets.
@immutable
class StepperThemeData {
  /// Creates theme data for stepper widgets.
  const StepperThemeData({
    this.activeStepColor,
    this.inactiveStepColor,
    this.completeStepColor,
    this.errorStepColor,
    this.disabledStepColor,
    this.editingStepColor,
    this.connectorColor,
    this.activeStepTitleStyle,
    this.inactiveStepTitleStyle,
    this.stepSubtitleStyle,
    this.iconSize = 24.0,
    this.connectorHeight = 24.0,
    this.stepPadding = const EdgeInsets.all(8.0),
    this.iconSpacing = 12.0,
    this.margin,
    this.elevation = 0.0,
  });

  /// Color for active steps.
  final Color? activeStepColor;

  /// Color for inactive steps.
  final Color? inactiveStepColor;

  /// Color for completed steps.
  final Color? completeStepColor;

  /// Color for steps with errors.
  final Color? errorStepColor;

  /// Color for disabled steps.
  final Color? disabledStepColor;

  /// Color for steps being edited.
  final Color? editingStepColor;

  /// Color for the connector lines between steps.
  final Color? connectorColor;

  /// Text style for active step titles.
  final TextStyle? activeStepTitleStyle;

  /// Text style for inactive step titles.
  final TextStyle? inactiveStepTitleStyle;

  /// Text style for step subtitles.
  final TextStyle? stepSubtitleStyle;

  /// Size of the step icon.
  final double iconSize;

  /// Height of the connector between steps.
  final double connectorHeight;

  /// Padding around each step.
  final EdgeInsets stepPadding;

  /// Spacing between the icon and content.
  final double iconSpacing;

  /// Margin around the entire stepper.
  final EdgeInsets? margin;

  /// Elevation of the stepper.
  final double elevation;

  /// Creates a copy of this theme data with the given fields replaced.
  StepperThemeData copyWith({
    Color? activeStepColor,
    Color? inactiveStepColor,
    Color? completeStepColor,
    Color? errorStepColor,
    Color? disabledStepColor,
    Color? editingStepColor,
    Color? connectorColor,
    TextStyle? activeStepTitleStyle,
    TextStyle? inactiveStepTitleStyle,
    TextStyle? stepSubtitleStyle,
    double? iconSize,
    double? connectorHeight,
    EdgeInsets? stepPadding,
    double? iconSpacing,
    EdgeInsets? margin,
    double? elevation,
  }) {
    return StepperThemeData(
      activeStepColor: activeStepColor ?? this.activeStepColor,
      inactiveStepColor: inactiveStepColor ?? this.inactiveStepColor,
      completeStepColor: completeStepColor ?? this.completeStepColor,
      errorStepColor: errorStepColor ?? this.errorStepColor,
      disabledStepColor: disabledStepColor ?? this.disabledStepColor,
      editingStepColor: editingStepColor ?? this.editingStepColor,
      connectorColor: connectorColor ?? this.connectorColor,
      activeStepTitleStyle: activeStepTitleStyle ?? this.activeStepTitleStyle,
      inactiveStepTitleStyle: inactiveStepTitleStyle ?? this.inactiveStepTitleStyle,
      stepSubtitleStyle: stepSubtitleStyle ?? this.stepSubtitleStyle,
      iconSize: iconSize ?? this.iconSize,
      connectorHeight: connectorHeight ?? this.connectorHeight,
      stepPadding: stepPadding ?? this.stepPadding,
      iconSpacing: iconSpacing ?? this.iconSpacing,
      margin: margin ?? this.margin,
      elevation: elevation ?? this.elevation,
    );
  }

  /// Linearly interpolate between two stepper theme data objects.
  static StepperThemeData lerp(StepperThemeData? a, StepperThemeData? b, double t) {
    if (identical(a, b)) return a ?? const StepperThemeData();
    return StepperThemeData(
      activeStepColor: Color.lerp(a?.activeStepColor, b?.activeStepColor, t),
      inactiveStepColor: Color.lerp(a?.inactiveStepColor, b?.inactiveStepColor, t),
      completeStepColor: Color.lerp(a?.completeStepColor, b?.completeStepColor, t),
      errorStepColor: Color.lerp(a?.errorStepColor, b?.errorStepColor, t),
      disabledStepColor: Color.lerp(a?.disabledStepColor, b?.disabledStepColor, t),
      editingStepColor: Color.lerp(a?.editingStepColor, b?.editingStepColor, t),
      connectorColor: Color.lerp(a?.connectorColor, b?.connectorColor, t),
      activeStepTitleStyle: TextStyle.lerp(a?.activeStepTitleStyle, b?.activeStepTitleStyle, t),
      inactiveStepTitleStyle: TextStyle.lerp(a?.inactiveStepTitleStyle, b?.inactiveStepTitleStyle, t),
      stepSubtitleStyle: TextStyle.lerp(a?.stepSubtitleStyle, b?.stepSubtitleStyle, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t) ?? 24.0,
      connectorHeight: lerpDouble(a?.connectorHeight, b?.connectorHeight, t) ?? 24.0,
      stepPadding: EdgeInsets.lerp(a?.stepPadding, b?.stepPadding, t) ?? const EdgeInsets.all(8.0),
      iconSpacing: lerpDouble(a?.iconSpacing, b?.iconSpacing, t) ?? 12.0,
      margin: EdgeInsets.lerp(a?.margin, b?.margin, t),
      elevation: lerpDouble(a?.elevation, b?.elevation, t) ?? 0.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepperThemeData &&
        other.activeStepColor == activeStepColor &&
        other.inactiveStepColor == inactiveStepColor &&
        other.completeStepColor == completeStepColor &&
        other.errorStepColor == errorStepColor &&
        other.disabledStepColor == disabledStepColor &&
        other.editingStepColor == editingStepColor &&
        other.connectorColor == connectorColor &&
        other.activeStepTitleStyle == activeStepTitleStyle &&
        other.inactiveStepTitleStyle == inactiveStepTitleStyle &&
        other.stepSubtitleStyle == stepSubtitleStyle &&
        other.iconSize == iconSize &&
        other.connectorHeight == connectorHeight &&
        other.stepPadding == stepPadding &&
        other.iconSpacing == iconSpacing &&
        other.margin == margin &&
        other.elevation == elevation;
  }

  @override
  int get hashCode {
    return Object.hash(
      activeStepColor,
      inactiveStepColor,
      completeStepColor,
      errorStepColor,
      disabledStepColor,
      editingStepColor,
      connectorColor,
      activeStepTitleStyle,
      inactiveStepTitleStyle,
      stepSubtitleStyle,
      iconSize,
      connectorHeight,
      stepPadding,
      iconSpacing,
      margin,
      elevation,
    );
  }
}

/// An inherited widget that provides stepper theme data to its descendants.
class StepperTheme extends InheritedTheme {
  /// Creates a stepper theme widget.
  const StepperTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The theme data for stepper widgets.
  final StepperThemeData data;

  /// Returns the stepper theme data from the closest [StepperTheme] ancestor.
  /// If there is no ancestor, it returns a default theme.
  static StepperThemeData of(BuildContext context) {
    final StepperTheme? stepperTheme = context.dependOnInheritedWidgetOfExactType<StepperTheme>();
    return stepperTheme?.data ?? const StepperThemeData();
  }

  @override
  bool updateShouldNotify(StepperTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return StepperTheme(data: data, child: child);
  }
}

/// Import helper for lerpDouble
double? lerpDouble(double? a, double? b, double t) {
  if (a == b || (a?.isNaN == true) && (b?.isNaN == true)) {
    return a;
  }
  a ??= 0.0;
  b ??= 0.0;
  return a * (1.0 - t) + b * t;
}