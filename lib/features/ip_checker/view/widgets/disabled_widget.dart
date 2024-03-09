import 'package:flutter/material.dart';

/// `DisabledWidget` is a `StatelessWidget` that wraps a child widget and visually
/// indicates whether it is disabled by applying a semi-transparent overlay.
class DisabledWidget extends StatelessWidget {
  /// Constructor for creating an instance of `DisabledWidget`.
  const DisabledWidget(
      {super.key, required this.disabled, required this.child});

  /// A flag indicating whether the widget is disabled.
  final bool disabled;

  /// The child widget to be wrapped and visually affected by the disabled state.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(disabled ? .3 : 0),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        position: DecorationPosition.foreground,
        child: child,
      ),
    );
  }
}
